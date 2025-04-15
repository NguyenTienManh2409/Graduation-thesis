output "ec2_public_ip" {
  description = "Public IP của EC2"
  value       = aws_instance.web.public_ip
}

output "ec2_sg" {
  value = aws_security_group.ec2_sg.id
}