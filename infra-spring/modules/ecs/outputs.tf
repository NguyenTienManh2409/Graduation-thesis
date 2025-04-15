output "ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "ecs_service_sg" {
  value = aws_security_group.ecs_service_sg.id
}