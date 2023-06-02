variable "engine_name" {
  description = "Enter the DB engine"
  type = string
  default = "mysql"
}

variable "db_name" {
  description = "Enter the name of the database to be created inside DB Instance"
  type = string 
  default = "tcw"
}

variable "user_name"{
    description = "Enter the username for DB"
    type = string
    default = "tcw"
}

variable "pass" {
    description = "Enter the password"
    default = "TheCloudWorld.2019"
}

variable "multi_az_deployment" {
    description = "Enable or disable multi-az deployment"
    type = bool
    default = false
}

variable "public_access" {
    description = "whether public access neede"
    type = bool
    default = false
}

variable "skip_final_snapshot"{
    type = bool
    default = false
}

variable "delete_automated_backups" {
  type = bool
  default = true
}

variable "instance_class" {
  type = string 
  default = "db.t2.micro"
}
