variable "ec2_ami_id" {
  description = "Amazon Machine Image id for defining an instance"
  type        = string
  default     = "ami-0c1ac8a41498c1a9c"
}

variable "ec2_instance_type" {
  description = "Type of ec2 instance"
  type        = string
  default     = "t3.micro"
}

variable "ec2_sg_id" {
  description = "EC2 security group id with alb_sg inbound"
  type        = string
}

variable "path_to_user_data" {
  description = "Path to user-data script file"
  type        = string
}

variable "subnet_id" {
  type = string
}

variable "ec2_instance_profile" {
  type = string
}