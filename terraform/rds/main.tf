provider "aws" {
  region  = "ap-northeast-1"
  version = "2.12.0"
  profile = "your-profile"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "app-name-tfstate"
    region  = "ap-northeast-1"
    key     = "rds/terraform.tfstate"
    encrypt = true
    profile = "your-profile"
  }
}

data "terraform_remote_state" "security_group" {
  backend = "s3"

  config = {
    bucket  = "app-name-tfstate"
    region  = "ap-northeast-1"
    key     = "security_group/terraform.tfstate"
    profile = "your-profile"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage      = var.storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  identifier             = var.app_name
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = var.subnet_group
  vpc_security_group_ids = ["${data.terraform_remote_state.security_group.outputs.db_sg_id}"]
  multi_az               = var.multi_az
  skip_final_snapshot    = true

  tags = {
    Name = var.app_name
  }

  lifecycle {
    ignore_changes = ["password"]
  }
}
