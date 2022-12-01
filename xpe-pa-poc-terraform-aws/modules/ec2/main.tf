resource "aws_instance" "main" {
  /*name = "${var.aws_ec2_name}"

  create_spot_instance = true
  spot_price             = "0.60"
  spot_type              = "persistent"*/

  ami                    = "ami-0163d8cef65cb85c3"
  instance_type          = "${var.instance_type}"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Name        = "aws-ec2-${var.aws_ec2_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}