

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = ["10.0.1.0/24", "10.0.2.0/24"][count.index]
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = ["10.0.3.0/24", "10.0.4.0/24"][count.index]
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
}

resource "aws_subnet" "db" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = ["10.0.5.0/24", "10.0.6.0/24"][count.index]
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
}


data "aws_ssm_parameter" "this" {
    name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}