variable "project" {
  description = "Tên dự án hoặc dịch vụ"
  type        = string
}

variable "key_name" {
  description = "Tên SSH key để connect vào EC2"
  type        = string
}

variable "db_name" {
  description = "Tên database của RDS"
  type        = string
}

variable "db_username" {
  description = "Username để login RDS"
  type        = string
}

variable "db_password" {
  description = "Password để login RDS"
  type        = string
  sensitive   = true
}

variable "image_url" {
  description = "URL của image trong ECR"
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

variable "desired_count" {
  description = "Số lượng ECS task cần chạy"
  type        = number
  default     = 1
}

