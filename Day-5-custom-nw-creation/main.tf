#Creation of VPC
resource "aws_vpc" "venkatesh_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "venkatesh_vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.venkatesh_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet_1"
  }
}
resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.venkatesh_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "subnet_2"
  }
}
resource "aws_internet_gateway" "venkatesh_igw" {
   vpc_id = aws_vpc.venkatesh_vpc.id
   tags = {
        Name = "venkatesh_igw"
    }
}
resource "aws_route_table" "venkatesh_rt" {
    vpc_id = aws_vpc.venkatesh_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.venkatesh_igw.id
    }
  
}

resource "aws_route_table_association" "venkatesh_rta" {
    subnet_id = aws_subnet.subnet_1.id
    route_table_id = aws_route_table.venkatesh_rt.id

  
}

resource "aws_security_group" "venkatesh_sg" {
    name        = "venkatesh-security-group"
    description = "Allow SSH and HTTP traffic"
    vpc_id      = aws_vpc.venkatesh_vpc.id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0 #any port
        to_port     = 0 
        protocol    = "-1" #any protocol
        cidr_blocks = ["0.0.0.0/0"] #any source
    }
}
resource "aws_instance" "venkatesh_instance" {
    ami = "ami-0d27e0fb3bac4d724"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet_1.id
    vpc_security_group_ids = [aws_security_group.venkatesh_sg.id]
  
}

# you can create private subnet 
# create Elastic IP and create nate gateway