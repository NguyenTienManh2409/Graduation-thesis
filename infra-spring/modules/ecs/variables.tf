variable "name" {
  description = "Tên dự án hoặc dịch vụ"
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
}

variable "rds_sg_cidr" {
  description = "The CIDR block for the RDS security group"
  type        = string
}

variable "cpu" {
  description = "Số lượng CPU cho ECS task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Số lượng memory cho ECS task"
  type        = string
  default     = "512"
}

variable "image_url" {
  description = "URL của image từ ECR"
  type        = string
}

variable "desired_count" {
  description = "Số lượng task ECS cần chạy"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "ID của VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Danh sách các subnet ID cho ECS task"
  type        = list(string)
}

variable "environment_variables" {
  description = "Biến môi trường cho container"
  type        = list(object({
    name  = string
    value = string
  }))
  default     = []
}