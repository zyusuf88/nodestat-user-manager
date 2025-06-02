variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_1" {
  description = "CIDR block for first public subnet"
  type        = string
}

variable "public_subnet_2" {
  description = "CIDR block for second public subnet"
  type        = string
}

variable "private_subnet_1" {
  description = "CIDR block for first private subnet"
}

variable "private_subnet_2" {
  description = "CIDR block for 2nd private subnet"
}

variable "az_1" {
  description = "Availability Zone for first public subnet"
  type        = string
}

variable "az_2" {
  description = "Availability Zone for second public subnet"
  type        = string

}
