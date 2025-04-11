# Creating VPC

resource "aws_vpc" "self" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "test-VPC"
  }
}