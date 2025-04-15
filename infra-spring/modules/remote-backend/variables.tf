variable "s3_bucket_name" {
  description = "Tên S3 bucket lưu state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Tên bảng DynamoDB để khóa state"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID để tạo Endpoint"
  type        = string
}

variable "route_table_ids" {
  description = "Danh sách Route Table ID cho VPC Endpoint"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}