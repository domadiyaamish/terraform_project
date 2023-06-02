data "aws_iam_instance_profile" "instance_profile" {
    name = "ec2"
}

data "aws_availability_zone" "az" {
    name = "ap-south-1a"
    all_availability_zones = false
    state = "available"
}

data "aws_key_pair" "key"{
    key_name = "dev-account"
}

data "aws_subnet" "selected" {
  vpc_id = "vpc-09918360e3fba6260"
  availability_zone = "ap-south-1b"
  filter {
    name = "tag:Name"
    values = ["tcw_public_subnet_az_1a"]
  }
}

data "aws_security_groups" "sg" {
    tags = {
      Name = "tcw_security_group"
    }
}