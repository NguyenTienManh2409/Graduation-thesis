resource "aws_ecs_cluster" "this" {
  name = "${var.name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = "arn:aws:iam::390402565201:role/ecsTaskExecutionRole"  

  container_definitions = jsonencode([{
    name      = "${var.name}-container"
    image     = var.image_url
    portMappings = [{
      containerPort = 8080
      protocol      = "tcp"
    }]
    environment = [ 
      {
        name  = "DATABASE_URL"
        value = "jdbc:mysql://phonestore.ccbao48yenjj.us-east-1.rds.amazonaws.com:3306/${var.db_name}"
      },
      {
        name  = "DB_USER"
        value = var.db_username
      },
      {
        name  = "DB_PASSWORD"
        value = var.db_password
      }
    ]
  }])
}

resource "aws_security_group" "ecs_service_sg" {
  name   = "${var.name}-ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [] 
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.rds_sg_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ecs-sg"
  }
}

resource "aws_ecs_service" "this" {
  name            = "${var.name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = false
    security_groups = [aws_security_group.ecs_service_sg.id]
  }
}