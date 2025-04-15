output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "Danh sách Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Danh sách Private Subnet IDs"
  value       = aws_subnet.private[*].id
}

output "route_table_ids" {
  value = aws_route_table.public[*].id 
}