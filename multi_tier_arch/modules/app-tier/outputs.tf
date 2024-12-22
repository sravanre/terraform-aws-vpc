output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "aws_security_group_app_id" {
    value = aws_security_group.app.id
}

output "aws_key_pair_deployer" {
    value = aws_key_pair.deployer.key_name
}