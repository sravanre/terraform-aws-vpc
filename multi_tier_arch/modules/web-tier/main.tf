resource "aws_instance" "web" {
  count = 2
  ami = "ami-01816d07b1128cd2d"  ## amazon linux 2
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[count.index]

  tags = {
    Name = "web-server-${count.index}"
  }
}