provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source            = "./modules/vpc"
  project           = var.project
  vpc_cidr          = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets   = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "ecs" {
  source               = "./modules/ecs"
  name                 = var.project
  vpc_id               = module.vpc.vpc_id 
  cpu                  = "256"
  memory               = "512"
  desired_count        = 1
  subnet_ids           = module.vpc.private_subnet_ids  
  rds_endpoint         = module.rds.rds_endpoint  
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  rds_sg_cidr          = "10.0.0.0/16"
  image_url            = module.ecr.repository_url  
}

module "ec2" {
  source          = "./modules/ec2"
  project         = var.project
  vpc_id          = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
  instance_type   = "t2.micro"
  key_name        = var.key_name
  rds_sg          = module.rds.rds_sg_id
}

# Module RDS (MySQL Database)
module "rds" {
  source             = "./modules/rds"
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_class     = "db.t3.micro"
  db_username        = "root"
  db_password        = "12345678"
  allowed_cidrs      = ["10.0.0.0/16"] 
  ecs_service_sg     = module.ecs.ecs_service_sg
}

module "ecr" {
  source   = "./modules/ecr"
  name     = var.project
}

module "remote-backend" {
  source              = "./modules/remote-backend"
  s3_bucket_name      = "remote-backend2409"
  dynamodb_table_name = "terraform-state"
  vpc_id              = module.vpc.vpc_id
  route_table_ids     = module.vpc.route_table_ids
  aws_region          = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "remote-backend2409"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
    encrypt = true
  }
}