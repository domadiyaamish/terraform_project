variable "engine_name" {
  description = "Enter the db engine"
  type = string
  default = "mysql"
}

variable "db_name" {
  description = "Enter a name of the database to be created inside DB Instance"
  type = string
  default = "tcw"
}

variable "user_name" {
  description = "Enter a user name for DB"
  type = string 
  default = "tcw"
}

variable "pass" {
    description = "enter the pass of DB"
    type = string
    default = "123amish"
}

variable "skip_final_snapshot" {
  description = "skip final snapshot"
  type = bool
  default = false
}

variable "delete_automated_backups" {
  description = "delete a automated backup"
  type = bool
  default = true
}

variable "multi_az" {
  description = "Enable or disable multi-az deployment"
  type        = bool
  default     = false
}

variable "publicly_access" {
    description = "Whether public access needed"
  type        = bool
  default     = false
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}