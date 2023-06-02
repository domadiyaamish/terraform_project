variable "ami_id" {
  type = string
  default = "ami-0f5ee92e2d63afc18"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "associate_public_ip" {
  type = bool
  default = true
}

variable "az" {
  type = string
  default = "ap-south-1"
}

variable "disable_api_termination" {
  type = bool
  default = false
}

variable "instance_profile" {
  type = string
  default = "ec2"
}

variable "key" {
  type = string
  default = "dev-account"
}

variable "sg" {
  type = list(any)
  default = ["sg-0bd9cb5e8794b456d"]
}

variable "subnet_id" {
  type = string
  default = "subnet-053f9b6d8e3e7a547"
}

variable "volume_size" {
  type = number
  default = 10
}

variable "application" {
  type = string
  default = "tcw"
}

variable "organization" {
  type = string
  default = "thecloudworld"
}

