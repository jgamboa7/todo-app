resource "aws_lb" "todo-app-alb" {
  name               = "todo-app-alb"
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_id
 
    tags = {
    Environment = "production-todo-app"
  }
}

resource "aws_lb_target_group" "todo_app_tg" {
  name        = "todo-app-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"  # or "ip" if using ECS or IP-based targets
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.todo-app-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"  # AWS default
  certificate_arn   = var.acm_certificate_arn      # You need a valid ACM cert here

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.todo_app_tg.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.todo-app-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

