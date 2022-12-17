variable "db_username" {
  description = "RDS root user name"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "db_region" {
  description = "RDS region"
  type        = string
  sensitive   = true
  default = "us-east-1"
}

variable "db_instance_class" {
  description = "RDS region"
  type        = string
  sensitive   = true
  default = "db.t3.micro"
}