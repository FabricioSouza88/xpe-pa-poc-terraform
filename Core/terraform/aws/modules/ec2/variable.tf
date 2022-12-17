variable "aws_ec2_name" {}

variable "instance_type" {
    description   = "AWS instance type"
    default       = "t2.micro"
    type          = string
}
