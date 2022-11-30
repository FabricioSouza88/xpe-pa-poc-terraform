data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "postgres_vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "postgres_subnet" "postgres_subnet" {
  name       = "postgres_subnet"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Postgres Subnet"
  }
}

module "security_group" {
    source = "../security_group"

    aws_security_group_name = "postgres_rds"
}

resource "aws_db_parameter_group" "postgres_parameter_group" {
  name   = "postgres"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  db_subnet_group_name   = aws_db_subnet_group.education.name
  vpc_security_group_ids = [aws_security_group.security_group.id]
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
