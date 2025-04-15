resource "aws_ecr_repository" "this" {
  name                 = "my-app"
  image_tag_mutability = "MUTABLE" 
  force_delete         = true 

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.name}-ecr"
  }
}