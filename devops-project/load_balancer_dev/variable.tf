

variable "lb_name" {
  type = string
  description = "lb name"
}

variable "is_external" {
  description = "lb name"
}


variable "lb_type" {
  type = string
  description = "lb type"
}

variable "alb_sg" {
    description = "sg for load balancer"
  
}

variable "public_subnet1" {
  description = "public subnet to associate with lb"
}

variable "public_subnet2" {
  description = "private subnet to associate with lb"
}

variable "environment" {
  type = string
  description = "lb environment"
}

# setting up target grp variables


variable "target_grp_name" {
  type = string
  description = "tg name"
}

variable "target_grp_port" {
  type = string
  description = "tg port"
}

variable "target_grp_protocol" {
  type = string
  description = "tg protocol"
}

variable "main_vpc" {
  type = string
  description = "vpc main"
}

variable "aws_instance_id" {
  type = string
  description = "vpc main"
}

variable "lb_target_group_attachment_port" {
  type = string
  description = "vpc main"
}

variable "lb_listner_port" {
  type = string
  description = "vpc main"
}

variable "lb_listner_protocol" {
  type = string
  description = "vpc main"
}


variable "lb_listner_default_action" {
  type = string
  description = "vpc main"
}

variable "target_type_tg" {
  type = string
  description = "vpc main"
}