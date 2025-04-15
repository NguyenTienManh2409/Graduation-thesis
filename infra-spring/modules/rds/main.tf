resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.ecs_service_sg]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = []  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phonestore"
  }
}

# Tạo RDS MySQL instance
resource "aws_db_instance" "rds" {
  identifier            = "phonestore"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  username            = var.db_username
  password            = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
  skip_final_snapshot  = true

  tags = {
    Name = "phonestore"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-db-subnet-group"
  }
}