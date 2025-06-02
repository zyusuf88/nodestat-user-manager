# S3 bucket for SQL uploads
resource "aws_s3_bucket" "lambda_sql_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}
resource "aws_s3_object" "init_sql" {
  bucket = aws_s3_bucket.lambda_sql_bucket.id
  key    = "init-users.sql"
  source = "${path.module}/init-users.sql"
  etag   = filemd5("${path.module}/init-users.sql")
  content_type = "application/sql"

  depends_on = [aws_s3_object.lambda_zip]

}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.lambda_sql_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

#Lambda function that gets triggered by S3 uploads
resource "aws_lambda_function" "init_db" {
  function_name    = "db-seed-handler"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  role             = var.lambda_exec_role_arn
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")
  s3_bucket     = var.s3_bucket_name
  s3_key        = "lambda.zip"

vpc_config {
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [var.security_group_id]
}


  environment {
    variables = {
      DB_USERNAME = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
      DB_HOST    = var.db_host
    }
  }

  timeout = 300

  depends_on = [aws_s3_object.lambda_zip]
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.init_db.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}

resource "aws_s3_bucket_notification" "trigger" {
  bucket = aws_s3_bucket.lambda_sql_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.init_db.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "init-"
    filter_suffix       = ".sql"
  }

  depends_on = [
    aws_lambda_permission.allow_s3,
    aws_s3_bucket.lambda_sql_bucket
  ]
}

resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_sql_bucket.id
  key    = "lambda.zip"
  source = "${path.module}/lambda.zip"
  etag   = filemd5("${path.module}/lambda.zip")
}
