resource "aws_instance" "name" {
  ami = "ami-08c46876c64a927b8"
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-server"
  }
}

resource "aws_s3_bucket" "dev" {
    bucket = "terraform-practice-venky-7620"
  
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.dev.id
  versioning_configuration {
    status = "Enabled"
  }
}