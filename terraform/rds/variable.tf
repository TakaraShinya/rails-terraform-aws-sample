variable "vpc_id" {
  default = "your-vpc-id"
}

variable "subnet_group" {
  default = "pvt-subnet-group"
}

variable "db_name" {
  default = "your-db-name"
}

variable "app_name" {
  default = "your-db-name"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7.26"
}

variable "instance_class" {
  default = "db.t2.small"
}

variable "storage_type" {
  default = "gp2"
}

variable "storage" {
  default = 20
}

variable "multi_az" {
  default = "false"
}
