output "allow_alb_sg_id" {
  value = aws_security_group.allow_alb_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}