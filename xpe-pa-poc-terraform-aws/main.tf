// AWS provider configurations
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

// Available zones configuration
data "aws_availability_zones" "available" {}

// Creates a database instance
module "rds-postgresdb" {
    source = "./modules/rds/postgresdb"

    db_username = "analyticsdb"
    db_password = "analyticsdbmaster"
}

// Creates virtual machine instances
locals {
  virtual_machines = [
    {
      ip_address    = "10.0.0.1"
      name          = "api-server"
      instance_type = "t2.micro"
    },
    {
      ip_address    = "10.0.0.2"
      name          = "opt-server"
      instance_type = "t2.micro"
    }
  ]
}    


module "ec2-instances" {
    source = "./modules/ec2"

    for_each   = {
        for index, vm in local.virtual_machines:
        vm.name => vm
    }
    aws_ec2_name    = each.value.name
    instance_type   = each.value.instance_type
}

// Create a S3 Module
module "file_bucket" {
    source = "./modules/s3"

    aws_s3_bucket_name = "xpe-mba-pa"
}

// Create a SQS Queue Module
module "sqs_queue" {
    source = "./modules/sqs"

    sqs_queue_name = "xpe-mba-pa"
}