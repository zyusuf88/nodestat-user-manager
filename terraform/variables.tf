variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}


variable "record_name" {
  description = "The subdomain or record name (e.g., tm)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_1" {
  description = "Availability Zone for first public subnet"
  type        = string
  default = "eu-west-2a"
}

variable "az_2" {
  description = "Availability Zone for second public subnet"
  type        = string
  default = "eu-west-2b"
}

variable "region" {
  default = "eu-west-2"
}

variable "public_subnet_1" {
  description = "CIDR block for first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2" {
  description = "CIDR block for second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1" {
  description = "CIDR block for first private subnet"
default = "10.0.3.0/24"
}

variable "private_subnet_2" {
  description = "CIDR block for 2nd private subnet"
default = "10.0.4.0/24"
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the services"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}
variable "ssm_parameter_access" {
  description = "The ARN of the SSM Parameter Access policy"
  type        = string
}

variable "container_image" {
  type = string
}

# In your variables.tf or root main.tf
variable "db_username" {
  description = "The database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_secret_name" {
  description = "The name of the secret in Secrets Manager"
  type        = string
}

variable "s3_bucket_name" {
  type = string

}

variable "db_host" {
  description = "MySQL hostname"
  type        = string
}

variable "db_identifier" {
  description = "RDS database identifier"
  type        = string
}


variable "seeder_container" {
  description = "ECR image URI for the DB seeder container"
  type        = string
}
