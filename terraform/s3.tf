resource "aws_s3_bucket" "s3devbucket" {
  bucket = var.bucket
  #"fwojtkow-dev-bucket"
  acl    = "private"

  tags = {
    Name        = "Env"
    Environment = "${terraform.workspace}"
  }
}