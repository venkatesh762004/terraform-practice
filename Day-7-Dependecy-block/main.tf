variable "project_name" {
  type = string
}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

  depends_on = [aws_s3_bucket.name]
}

resource "aws_s3_bucket" "name" {
  bucket = "${var.project_name}-bucket"
}