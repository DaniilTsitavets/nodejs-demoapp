variable "docdb_sg" {
  type = string
}

variable "docdb_master_password" {
  type = string
}

variable "docdb_master_username" {
  type = string
}

variable "docdb_instance_count" {
  type = string
}

variable "docdb_instance_class" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}