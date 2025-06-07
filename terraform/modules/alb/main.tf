resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids


  #checkov requirement
  drop_invalid_header_fields = true
  enable_deletion_protection = false # set to false for testing purposes

    access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    enabled = true
  }

  tags = {
    Name = var.alb_name
  }

}

resource "aws_lb_target_group" "this" {
  name        = var.alb_tg_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
 deregistration_delay = "30"
 slow_start = 30


health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200-499"
    path                = "/"
    port                = 3000
    protocol            = "HTTP"
    timeout             = 10
    unhealthy_threshold = 2
}



  depends_on = [ aws_lb.this ]
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {

  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn

}
}
