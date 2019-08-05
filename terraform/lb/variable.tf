variable "acm_domain_name" {
  default = "*.your.domain"
}

variable "vpc_id" {
  default = "your-vpc-id"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-000111222", "subnet-333444555"]
}

variable "app_name" {
  default = "your-app-name"
}

variable "lb_internal" {
  default = true
}

variable "lb_type" {
  default = "application"
}

variable "port" {
  default = 80
}

variable "listener_port" {
  default = 443
}

variable "protocol" {
  default = "HTTP"
}

variable "listener_protocol" {
  default = "HTTPS"
}

variable "listener_default_action" {
  default = "forward"
}

variable "target_type" {
  default = "instance"
}

variable "health_check_path" {
  default = "/healthcheck"
}

variable "healtch_check_timeout" {
  default = 5
}

variable "healthy_threshold" {
  default = 5
}

variable "unhealthy_threshold" {
  default = 2
}

variable "healtch_check_interval" {
  default = 15
}

variable "health_check_matcher" {
  default = "200-399"
}

variable "ssl_policy" {
  default = "ELBSecurityPolicy-2016-08"
}
