resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-dev-vpc"
  }
}

resource "aws_subnet" "test" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform-test-subnet"
  }
}