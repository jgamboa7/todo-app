output "vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_ipv4" {
  value = aws_vpc.main.cidr_block
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}


