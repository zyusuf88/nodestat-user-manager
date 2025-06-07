variable "lambda_exec_role_arn" {
  type        = string
}


variable "lambda_package" {
  type        = string
}


variable "s3_bucket_name" {
  type        = string
}

variable "db_host" {
  description = "MySQL hostname"
  type        = string
}

variable "db_username" {
  description = "MySQL username"
  type        = string
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
}


variable "security_group_id" {
  description = "Security group for ECS service"
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}
