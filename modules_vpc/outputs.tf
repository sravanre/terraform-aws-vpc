output "privateIP" {
  description = "private ip of the ec2 instance that is created"
  value = aws_instance.my-instance1.private_ip
}


output "publicIP" {
  description = "public ip address of the instance"
  value = aws_instance.my-instance1.public_ip
}