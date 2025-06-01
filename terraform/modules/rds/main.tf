resource "aws_secretsmanager_secret" "rds_secret" {
  name        = var.db_secret_name
  description = "RDS credentials for ${var.db_name}"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    dbname   = var.db_name
    host     = aws_db_instance.this.address
  })
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.db_identifier}-subnet-group"
  description = "Subnet group for ${var.db_identifier}"
  subnet_ids  = var.private_subnet_ids
}

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
  vpc_security_group_ids  = [var.sg_id]
  skip_final_snapshot     = true
  publicly_accessible     = false

  tags = {
    Name = var.db_identifier
  }
}
