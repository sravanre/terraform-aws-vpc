resource "aws_instance" "app" {
  count         = 2
  ami           = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "App-Server-${count.index}"
  }
}

# resource for creating a keypair for the app server i have the keypain in my c drive which i want to use
resource "aws_key_pair" "deployer" {
  key_name   = "deploy"
public_key = file("C:\\Users\\User\\.ssh\\project_key.pub")
}



resource "aws_security_group" "app" {
  name        = "app-tier-sg"
  description = "Security group for the App Tier"
  vpc_id      = var.vpc_id

  # Allow inbound traffic from Web Tier
  ingress {
    description      = "Allow traffic from Web Tier"
    from_port        = 8080  # Change if your app uses a different port
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = [var.aws_security_group_web_id]
  }

  # Allow all outbound traffic (e.g., to the database)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
