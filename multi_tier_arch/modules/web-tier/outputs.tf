output "web_public_ips" {
  value = aws_instance.web[*].public_ip
}

output "aws_security_group_web_id" {
    value = aws_security_group.web.id
}