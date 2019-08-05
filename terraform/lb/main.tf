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
    key     = "lb/terraform.tfstate"
    encrypt = true
    profile = "your-profile"
  }
}

data "aws_acm_certificate" "acm" {
  domain = var.acm_domain_name
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

data "terraform_remote_state" "ec2" {
  backend = "s3"

  config = {
    bucket  = "app-name-tfstate"
    region  = "ap-northeast-1"
    key     = "ec2/terraform.tfstate"
    profile = "your-profile"
  }
}

resource "aws_lb" "lb" {
  name               = "${var.app_name}-lb"
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [data.terraform_remote_state.security_group.outputs.lb_sg_id]
  subnets            = var.subnet_ids

  tags = {
    Name = var.app_name
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "${var.app_name}-tg"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    timeout             = var.healtch_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.healtch_check_interval
    matcher             = var.health_check_matcher
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = data.aws_acm_certificate.acm.arn

  default_action {
    type             = var.listener_default_action
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_target_group_attch" {
  count            = data.terraform_remote_state.ec2.outputs.instance_count
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = keys(data.terraform_remote_state.ec2.outputs.instance_ids)[count.index]
}
