############Create a vpc####################

resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = var.vpc_name
  }
}

###########Create a internet Gateway##########

resource "aws_internet_gateway" "my_IGW" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = var.igw_tag
  }
}

#########create a public subnet ######################

resource "aws_subnet" "public_subnet_1" {
  vpc_id =  aws_vpc.myVPC.id
  cidr_block = var.public_subnets_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_tag_1
  }
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_tag_2
  }
}



#########create a Database subnet ######################

resource "aws_subnet" "database_subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.database_subnets_cidr_1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = var.public_subnet_tag_1
  }
}


resource "aws_subnet" "database_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.database_subnets_cidr_2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = var.public_subnet_tag_2
  }
}


#########public Route################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = var.public_route_table_tag
  }
}


resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_IGW.id
}

#######database route table#############

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.myVPC.id
}

############Route Table Association with subnet#############

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.database_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "database_route_table_association_1" {
  subnet_id      = aws_subnet.database_subnet_1.id
  route_table_id = aws_route_table.database_route_table.id
}

resource "aws_route_table_association" "database_route_table_association_2" {
  subnet_id      = aws_subnet.database_subnet_2.id
  route_table_id = aws_route_table.database_route_table.id
}

###########security group ################

resource "aws_security_group" "mysg" {
  name        = "tcw_security_group"
  description = "Allow all the traffic"
  vpc_id      = aws_vpc.myVPC.id

  ingress = [
    {
      description      = "All Traffic"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "all outgoing traffic"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  tags = {
    Name = "tcw_security_group"
  }
}