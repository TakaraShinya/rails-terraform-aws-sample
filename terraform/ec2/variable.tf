variable "ami_id" {
  default = "ami-0c3fd0f5d33134a76"
}

variable "instance_count" {
  default = 1
}

variable "subnets" {
  default = {
    "0" = "subnet-000111222"
    "1" = "subnet-333444555"
  }
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_pair" {
  default = "your-keypair-name"
}

variable "app_name" {
  default = "your-app-name"
}