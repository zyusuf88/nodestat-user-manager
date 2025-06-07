resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  name        = "${var.project_name}-sg"
  description = "Security group for application"


  ingress {
    description = "http access"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks


  }

  ingress {
     description = "allow https inbound traffic"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "allow container access"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
  description = "MySQL database access"
  from_port   = var.db_port
  to_port     = var.db_port
  protocol    = "tcp"
  self = true
}

  egress {
    description = " outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}
