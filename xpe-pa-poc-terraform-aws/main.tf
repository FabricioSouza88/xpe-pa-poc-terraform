// AWS provider configurations
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

// Available zones configuration
data "aws_availability_zones" "available" {}

// Create a S3 Module
module "file_bucket" {
    source = "./modules/s3"

    aws_s3_bucket_name = "xpe-mba-pa"
}

module "postgresdb" {
    source = "./modules/postgresdb"

    db_username = "analyticsdb"
    db_password = "analyticsdbmaster"
}