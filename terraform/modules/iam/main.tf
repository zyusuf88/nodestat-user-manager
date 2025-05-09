
# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs-task-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "ssm_parameter_access" {
#   name        = "ssm-parameter-access-policy"
#   description = "Allows access to SSM parameters for the coder-portal app"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = "ssm:GetParameters",
#         Resource = "arn:aws:ssm:eu-west-2:*:parameter/coder-portal/*"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "secrets_manager_access" {
#   name        = "ecs-secrets-manager-access"
#   description = "Allows ECS tasks to retrieve specific secrets"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = "secretsmanager:GetSecretValue",
#         Resource = "arn:aws:secretsmanager:eu-west-2:730335356758:secret:prod/mysql/this-project-db-new-*"
#       }
#     ]
#   })
# }
# resource "aws_iam_policy" "ecs_task_execution_role_policy" {
#   name        = "ecs-task-execution-role-policy"
#   description = "Policy for ECS task to push logs to CloudWatch"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:DescribeLogStreams"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# # attached policies as read only
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ecr" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ssm" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.ssm_parameter_access.arn
# }

# resource "aws_iam_role_policy_attachment" "task_execution_secrets_policy" {
#   role       = "ecs-task-execution-role"  # or use a reference to your role resource
#   policy_arn = aws_iam_policy.secrets_manager_access.arn
# }

# resource "aws_iam_role_policy" "ecs_task_execution_secrets_policy" {
#   name = "ecs-task-execution-secrets-policy"
#   role = aws_iam_role.ecs_task_execution_role.name

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "secretsmanager:GetSecretValue"
#         ],
#         Resource = var.rds_secret_arn

#       }
#     ]
#   })
# }


# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs-task-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # ECS Task Role: Network and Execution Permissions
# resource "aws_iam_policy" "ecs_task_network_access" {
#   name        = "ecs-task-network-access-policy"
#   description = "Allow ECS tasks to interact with VPC and network interfaces"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = [
#           "ec2:DescribeNetworkInterfaces",
#           "ec2:CreateNetworkInterface",
#           "ec2:DeleteNetworkInterface",
#           "ec2:AssignPrivateIpAddresses"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# # ECS Task Execution Role Policies
# resource "aws_iam_policy" "ecs_task_execution_role_policy" {
#   name        = "ecs-task-execution-role-policy"
#   description = "Policy for ECS task to push logs to CloudWatch"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = [
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:DescribeLogStreams"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "ssm_parameter_access" {
#   name        = "ssm-parameter-access-policy"
#   description = "Allows access to SSM parameters"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = "ssm:GetParameters",
#         Resource = "arn:aws:ssm:eu-west-2:*:parameter/coder-portal/*"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "secrets_manager_access" {
#   name        = "ecs-secrets-manager-access"
#   description = "Allows ECS tasks to retrieve specific secrets"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = "secretsmanager:GetSecretValue",
#         Resource = var.rds_secret_arn
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "lambda_execution_role" {
#   name = "lambda-execution-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }


# # Attach all policies
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ecr" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ssm" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.ssm_parameter_access.arn
# }

# resource "aws_iam_role_policy_attachment" "task_execution_secrets_policy" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.secrets_manager_access.arn
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_network" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.ecs_task_network_access.arn
# }

resource "aws_iam_role_policy" "ecs_task_execution_secrets_policy" {
  name = "ecs-task-execution-secrets-policy"
  role = aws_iam_role.ecs_task_execution_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = var.rds_secret_arn

      }
    ]
  })
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ECS Task Role: Network and Execution Permissions
resource "aws_iam_policy" "ecs_task_network_access" {
  name        = "ecs-task-network-access-policy"
  description = "Allow ECS tasks to interact with VPC and network interfaces"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses"
        ],
        Resource = "*"
      }
    ]
  })
}

# ECS Task Execution Role Policies
resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name        = "ecs-task-execution-role-policy"
  description = "Policy for ECS task to push logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ssm_parameter_access" {
  name        = "ssm-parameter-access-policy"
  description = "Allows access to SSM parameters"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ssm:GetParameters",
        Resource = "arn:aws:ssm:eu-west-2:*:parameter/coder-portal/*"
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_access" {
  name        = "ecs-secrets-manager-access"
  description = "Allows ECS tasks to retrieve specific secrets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "secretsmanager:GetSecretValue",
        Resource = var.rds_secret_arn
      }
    ]
  })
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


# Attach all policies
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ecr" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_ssm" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ssm_parameter_access.arn
}

resource "aws_iam_role_policy_attachment" "task_execution_secrets_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.secrets_manager_access.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_network" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_network_access.arn
}



# # Lambda Execution Role: Policy for accessing Secrets Manager and S3
# resource "aws_iam_policy" "lambda_s3_secrets_policy" {
#   name        = "lambda-s3-secrets-policy"
#   description = "Lambda access to S3 and Secrets Manager"
#   policy      = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Action    = "secretsmanager:GetSecretValue"
#         Resource  = var.rds_secret_arn
#       },
#       {
#         Effect    = "Allow"
#         Action    = [
#           "s3:GetObject",
#           "s3:ListBucket"
#         ]
#         Resource  = [
#           "arn:aws:s3:::${var.s3_bucket_name}",
#           "arn:aws:s3:::${var.s3_bucket_name}/*"
#         ]
#       }
#     ]
#   })
# }

# # Attach the Lambda S3 and Secrets Manager policy to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_s3_secrets_attachment" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = aws_iam_policy.lambda_s3_secrets_policy.arn
# }
