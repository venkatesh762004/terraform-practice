resource "aws_instance" "name" {
  ami           = "ami-004d1eaf8eaa0107d"
  instance_type = "t2.medium"

  tags = {
    "Name" = "terraform-instance"
  }
}

