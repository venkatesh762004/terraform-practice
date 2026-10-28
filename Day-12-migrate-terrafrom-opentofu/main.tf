resource aws_instance "venkatesh-instance" {
    ami = "ami-0c55b159cbfafe1d0"
    instance_type = "t2.micro"
    tags = {
        Name = "venkatesh-instance"
    }
}
resource "aws_security_group" "venkatesh-sg" {
    name = "venkatesh-sg"
    description = "Security group for venkatesh-instance"
    provisioner "local-exec" {
        command = "echo 'Security group created successfully!'"
    }
}    
resource "vpc" "venkatesh-vpc" {
    cidr_block = "10.0.0.0/160"
    tags = {
        Name = "venkatesh-vpc"
    }
}
resource "subnet" "venkatesh-subnet" {
    vpc_id = aws_vpc.venkatesh-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "pub-subnet"
    }
}
