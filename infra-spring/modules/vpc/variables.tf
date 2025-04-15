variable "project" {
  description = "Tên dự án"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR Block cho VPC"
  type        = string
}

variable "public_subnets" {
  description = "CIDR Blocks cho Public Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR Blocks cho Private Subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Danh sách Availability Zones"
  type        = list(string)
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}