# resource "aws_lambda_function" "db_init" {
#   function_name = "db-init-function"
#   runtime       = "nodejs14.x"
#   handler       = "index.handler"
#   role          = aws_iam_role.lambda_exec_role.arn
#   zip_file      = file("./db-init-lambda/db-init-lambda.zip")

#   environment {
#     variables = {
#       DB_SECRET_ARN = var.db_secret_arn
#       S3_BUCKET     = var.s3_bucket_name
#       SQL_KEY       = "init.sql"
#     }
#   }
# }
