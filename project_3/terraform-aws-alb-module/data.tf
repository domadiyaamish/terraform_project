data "aws_subnet" "private1" {
  vpc_id = "vpc-09918360e3fba6260"
  filter {
    name   = "tag:Name"
    values = ["tcw_public_subnet_az_1*"]
  }
}

data "aws_vpc" "selected" {
  id = "vpc-09918360e3fba6260"
}

data "aws_subnet" "private" {
  for_each = { private1 = "subnet-0963a71c5b31ad67e" }  # Replace "private1" with a suitable identifier
  id       = each.value
}
data "aws_security_groups" "sg" {
  tags = {
    Name = "tcw_security_group"
  }
}