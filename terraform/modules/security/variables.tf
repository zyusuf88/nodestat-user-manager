variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the services"
  type        = list(string)
}

variable "http_port" {
  description = "Port for HTTP access"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Port for HTTPS access"
  type        = number
  default     = 443
}

variable "app_port" {
  description = "Port for the app container"
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Port for MySQL or database access"
  type        = number
  default     = 3306
}

