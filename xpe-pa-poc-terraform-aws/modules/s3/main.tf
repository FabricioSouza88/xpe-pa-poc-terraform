resource "aws_s3_bucket" "main" {
  bucket = "${var.aws_s3_bucket_name}"
  acl = "${var.aws_s3_bucket_acl}"
}
