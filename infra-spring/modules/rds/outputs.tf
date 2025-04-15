output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "rds_arn" {
  value = aws_db_instance.rds.arn
}