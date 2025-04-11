
# Creating  Route Table

resource "aws_route_table" "test-RT" {
  vpc_id = aws_vpc.self.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-IG.id
  }
  tags = {
    Name = "test-RT"
  }
}