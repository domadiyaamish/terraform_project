
data "aws_subnet" "selected" {
  vpc_id = "vpc-09918360e3fba6260"
  availability_zone = "ap-south-1a"
  filter {
    name = "tag:Name"
    values = ["tcw_database_subnet_az*"]
  }
}

data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_security_group" "tcw_sg" {
    filter {
        name = "tag:Name"
        values = ["tcw_security_group"]
    }
}