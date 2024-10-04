
variable "instance_name" {
  type = string
  description = "ec2 instance name"
}

variable "instance_type" {
  type = string
  description = "ec2 instance type"
}

variable "ami_id" {
  type = string
  description = "ami id for instance creation"
}

variable "enable_public_ip_address" {
  type = string
  description = "enable_public_ip_address"
}

variable "security_gps" { 
  description = "security grps"
}

variable "public_subnetid" {
  type = string
  description = "public subnet"
}

variable "user_data_install_apache" {
  description = "user data need to install jenkins"
}