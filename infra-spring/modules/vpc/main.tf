provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    "Name" = "custom-vpc"
  }
}

locals {
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.private_subnets[count.index]
  availability_zone       = local.availability_zones[count.index % length(local.availability_zones)]
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private-subnet-${count.index + 1}"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.availability_zones[count.index % length(local.availability_zones)]
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-${count.index + 1}"
  }
}

# Internet Gateway (IGW) cho Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "custom-igw"
  }
}

# Route Table cho Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "public-route-table"
  }
}

# Associate Public Subnets với Route Table
resource "aws_route_table_association" "public_association" {
  for_each       = { for idx, subnet in aws_subnet.public : idx => subnet }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Elastic IP (EIP) cho NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT Gateway cho Private Subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id 

  tags = {
    Name = "${var.project}-nat-gateway"
  }
}

# Route Table cho Private Subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    "Name" = "private-route-table"
  }
}

# Associate Private Subnets với Private Route Table
resource "aws_route_table_association" "private_association" {
  for_each       = { for idx, subnet in aws_subnet.private : idx => subnet }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# Create VPC endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = aws_route_table.public[*].id 
  tags = {
    Name = "${var.project}-s3-endpoint"
  }
}