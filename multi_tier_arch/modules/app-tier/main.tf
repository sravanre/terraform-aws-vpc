resource "aws_instance" "app" {
  count         = 2
  ami           = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_ids[count.index]

  tags = {
    Name = "App-Server-${count.index}"
  }
}