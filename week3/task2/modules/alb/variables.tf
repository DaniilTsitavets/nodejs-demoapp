variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ASG"
  type = list(string)
}

variable "alb_sg" {
  description = "ALB security group with inbound 80 port"
  type = string
}

variable "environment" {
  description = "Work environment name e.g dev/production"
  type = string
}