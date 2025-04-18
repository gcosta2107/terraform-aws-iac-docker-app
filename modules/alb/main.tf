resource "aws_lb" "application_lb" {
  name               = "alb-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]

  subnets = var.subnet_public_ids

  tags = {
    Name    = "alb-web"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "tg-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name    = "tg-web"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}