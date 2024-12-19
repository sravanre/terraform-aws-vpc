output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}