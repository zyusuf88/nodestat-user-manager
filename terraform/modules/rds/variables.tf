variable "db_username" {
  description = "Username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_secret_name" {
  description = "Name for the secret in Secrets Manager"
  type        = string
}

variable "db_identifier" {
  description = "The identifier of the RDS instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be deployed"
  type        = string
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for RDS subnet group"
}

variable "sg_id" {
  type = string
}
