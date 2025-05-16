output "todo_app_tg_arn" {
  value = aws_lb_target_group.todo_app_tg.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}