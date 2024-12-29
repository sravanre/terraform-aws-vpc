resource "aws_instance" "web" {
  count = 2
  ami = "ami-01816d07b1128cd2d"  ## amazon linux 3
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name                = aws_key_pair.web-deployer.key_name  # Add this line
  associate_public_ip_address = true
  
  tags = {
    Name = "web-server-${count.index}"
  }
}

resource "aws_security_group" "web" {
  name        = "web-tier-sg"
  description = "Security group for the Web Tier"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP/HTTPS traffic from the internet
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH from a specific IP (replace x.x.x.x/32 with your IP)
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (default for AWS SGs)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "web-deployer" {
  key_name   = "web-deploy"
public_key = file("C:\\Users\\User\\.ssh\\project_key.pub")
}

