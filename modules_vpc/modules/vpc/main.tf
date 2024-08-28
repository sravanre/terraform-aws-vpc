provider "aws" {
    region = var.region
  
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "main-vpc-example"
  }
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"   # if i don't pass this it will create randomly

}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "this" {
  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id = aws_subnet.this.id
}

resource "aws_security_group" "this" {
  name = "ssh https http security group"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    description = "security group for 8080"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to port 8080 from anywhere (adjust as needed)
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to port 80 from anywhere (adjust as needed)
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to port 443 from anywhere (adjust as needed)
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" # Allow outbound traffic from the security group
    cidr_blocks = ["0.0.0.0/0"]
  }

}
data "aws_ssm_parameter" "this" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}