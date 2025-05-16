resource "aws_security_group" "allow_alb_sg" {
  name        = "allow_alb_sg"
  description = "Allow TLS inboud traffic from the alb"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_alb_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_to_ecs" {
  security_group_id                 = aws_security_group.allow_alb_sg.id
  referenced_security_group_id      = aws_security_group.alb_sg.id
  cidr_ipv4                         = var.cidr_ipv4
  from_port                         = 3000
  to_port                           = 3000
  ip_protocol                       = "tcp"  
}

resource "aws_vpc_security_group_egress_rule" "ecs_to_alb" {
  security_group_id = aws_security_group.allow_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "alb_sg" {
  name        = "todo_app_alb_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = var.cidr_ipv4
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}