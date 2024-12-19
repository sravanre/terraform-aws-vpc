output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "aws_security_group_app_id" {
    value = aws_security_group.app.id
}