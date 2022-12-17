data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "main" {
  key_name           = "key-${var.aws_ec2_name}"
  include_public_key = true

  filter {
    name   = "tag:Component"
    values = ["web"]
  }
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "${var.instance_type}"
  key_name               = data.aws_key_pair.main.key_name
  monitoring             = true

  tags = {
    Name        = "aws-ec2-${var.aws_ec2_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}