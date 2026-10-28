provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Day-11-Dynamic-SG-rules"
    }
  }
variable "ingress_rules" {
  description = "Inbound rules with different CIDR sources"

  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      description = "HTTP access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    },
    {
      description = "HTTPS access"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.2.0/24"]
    },
    {
      description = "SSH access from trusted network"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.0/24"]
    }
  ]
}

resource "aws_security_group" "dynamic_sg" {
  name        = "day-11-dynamic-sg"
  description = "Security group with dynamic ingress rules"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "day-1-1Dynamic-SG-rules"
  }
}

output "security_group_id" {
  value = aws_security_group.dynamic_sg.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}