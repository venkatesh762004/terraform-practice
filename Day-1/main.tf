resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "venkat-vpc"
    }
  
}

## Here VPC coud reference name is venkat-vpc
## resource local reference name is main