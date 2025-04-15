variable "project" {
  description = "Tên dự án"
  type        = string
}

variable "vpc_id" {
  description = "ID của VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID của Public Subnet"
  type        = string
}

variable "instance_type" {
  description = "Loại EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Tên của SSH key pair"
  type        = string
}

variable "rds_sg" {
  description = "The security group ID from the ECS module"
  type        = string
}