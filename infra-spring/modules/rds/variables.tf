variable "project" {
  description = "Tên dự án"
  type        = string
}

variable "vpc_id" {
  description = "ID của VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "Danh sách Private Subnets cho RDS"
  type        = list(string)
}

variable "instance_class" {
  description = "Loại instance của RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "Username của MySQL"
  type        = string
}

variable "db_password" {
  description = "Password của MySQL"
  type        = string
  sensitive   = true
}

variable "allowed_cidrs" {
  description = "Danh sách CIDR có thể truy cập RDS"
  type        = list(string)
  default     = ["10.0.0.0/16"] 
}

variable "ecs_service_sg" {
  description = "The security group ID from the ECS module"
  type        = string
}
