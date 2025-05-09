resource "random_id" "suffix" {
  byte_length = 4
}

# Create Secrets Manager Secret to store RDS credentials and DB host
resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "${var.db_secret_name}-${random_id.suffix.hex}"
  description = "RDS credentials for ${var.db_name}"
  recovery_window_in_days = 0
}

# Create the version of the secret with the database credentials and host (endpoint)
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    dbname   = var.db_name
    host     = aws_db_instance.this.address
  })
}

# Create RDS instance
resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = var.db_identifier
  }
}


# Define the DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name        = "${var.db_identifier}-subnet-group"
  description = "Subnet group for ${var.db_identifier}"
  subnet_ids  = var.subnet_ids
}

# Security group for RDS
resource "aws_security_group" "db" {
  name        = "${var.db_identifier}-sg"
  description = "Security group for ${var.db_identifier}"
  vpc_id      = var.vpc_id
}
