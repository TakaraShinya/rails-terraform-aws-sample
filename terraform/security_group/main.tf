provider "aws" {
  region  = "us-east-1"
  version = "2.12.0"
  profile = "tf-handson"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket  = "tf-handson-bucket"
    region  = "us-east-1"
    key     = "security_group/terraform.tfstate"
    encrypt = true
    profile = "tf-handson"
  }
}

# EC2に設定するセキュリティグループ
resource "aws_security_group" "ec2_security_group" {
  name   = "${var.app_name}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_security_group.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-sg"
  }
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_security_group.id
}

# ロードバランサーに設定するセキュリティグループ
resource "aws_security_group" "lb_security_group" {
  name   = "${var.app_name}-lb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-lb-sg"
  }
}

output "lb_sg_id" {
  value = aws_security_group.lb_security_group.id
}

# RDSに設定するセキュリティグループ
resource "aws_security_group" "db_security_group" {
  name   = "${var.app_name}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id]
  }

  ingress {
    from_port = "3306"
    to_port   = "3306"
    protocol  = "tcp"

    cidr_blocks = [
      "172.19.112.0/21", // Okinawa Office
    ]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-db-sg"
  }
}

output "db_sg_id" {
  value = aws_security_group.db_security_group.id
}
