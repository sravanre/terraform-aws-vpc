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
  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port = ingress.value["port"]
      to_port = ingress.value["port"]
      protocol = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidrs"]
      }
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