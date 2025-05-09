variable "project_name" {
  type        = string
}

variable "rds_secret_arn" {
  description = "ARN of the RDS secret in Secrets Manager"
  type        = string
}

variable "s3_bucket_name" {
  type        = string
   default     = ""
}
