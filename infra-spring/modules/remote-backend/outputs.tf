output "s3_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}