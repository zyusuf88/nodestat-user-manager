variable "container_image" {
  description = "ECR Image for the container"
  type        = string

}
variable "certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
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
  description = "The policy for accessing SSM parameters"
  type        = string
}


variable "security_group_id" {
  description = "Security group for ECS service"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for ALB and ECS"
  type        = list(string)
}


variable "domain_name" {
  default = "tm.yzeynab.com"
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "alb_listener" {
  description = "ALB HTTPS listener"
  type        = any
}

variable "http_listener_arn" {
  description = "ARN of the HTTP listener"
  type        = string
}

variable "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  type        = string
}

variable "db_secret_arn" {
  description = "The ARN of the RDS secret"
  type        = string
}

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

variable "db_host" {
  description = "The database host"
  type        = string
}

variable "rds_secret_arn" {
  description = "The ARN of the RDS secret"
  type        = string
}


variable "seeder_container" {
  description = "ECR image URI for the DB seeder container"
  type        = string
}
