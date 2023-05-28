provider "aws" {
  region = "ap-south-1"
}

#create a VPC block

resource "aws_vpc" "vpc_block" {
  cidr_block = "10.0.0.0/16"
}

#create a Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_block.id
  tags = {
    Name = "IGW"
  }
}

#create a Subnet 
resource "aws_subnet" "Subnet" {
  vpc_id     = aws_vpc.vpc_block.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet"
  }
}

#create a route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_block.id
  route  = []
  tags = {
    Name = "route_table"
  }
}

#create a route
resource "aws_route" "r" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.route_table]
}

#create a security group
resource "aws_security_group" "SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_block.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0    #all prot
    to_port          = 0    #all port
    protocol         = "-1" #alltraffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "all_traffic"
  }
}

#create a subnet association 
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Subnet.id
  route_table_id = aws_route_table.route_table.id
}

#create a ec2 instance
resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
  ami           = "ami-0f5ee92e2d63afc18"
  subnet_id     = aws_subnet.Subnet.id

  tags = {
    Name = "ec2_instance"
  }
}

