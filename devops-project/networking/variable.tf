# variables for setting up vpc

variable "cidr_block" {
  type = string
  description = "cidr block for vpc"
}

variable "vpc_name" {
  type = string
  description = "name for vpc"
}

# public subnet variables
variable "public_subnets_cidr" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]  # Example CIDR blocks
}

# variable "public_subnet" {
#   type = string
#   description = "public subnet name"
# }

variable "az_public_subnet" {
  type = list(string)
  description = "public subnet az"
}

# private subnet variables

variable "cidr_private_subent" {
  description = "private subnet cidr block"
}

variable "az_private_subnet" {
  type = list(string)
  description = "private subnet az"
}

variable "private_subnet" {
  type = string
  description = "private subnet name"
}

# internet gateway

variable "ig_name" {
  type = string
  description = "ig  name"
}

# route table
variable "public_subnet_rt_1" {
  type = string
  description = "public_subnet_rt_1"
}

variable "private_subnet_rt_1" {
  type = string
  description = "private_subnet_rt_1"
}

