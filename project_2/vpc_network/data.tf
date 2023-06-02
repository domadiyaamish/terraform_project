#############list all the available zone #############
data "aws_availability_zones" "available" {
  state = "available"
}