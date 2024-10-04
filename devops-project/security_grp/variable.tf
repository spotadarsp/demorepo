variable "vpc_id" {
  type = string
  description = "main vpc id"
}

variable "sg_ec2" {
  type = string
  description = "security grp  required for ec2 "
}

variable "devops_sg_1" {
  type = string
  description = "security grp  required for ec2"
}


variable "sg_rds" {
  type = string
  description = "security grp  required for ec2"
}

variable "devops_sg_2" {
  type = string
  description = "security grp  required for ec2"
}

variable "ec2_sg_name_for_python_api" {
  type = string
  description = "security grp  required for ec2"
}

