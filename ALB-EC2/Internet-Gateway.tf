
# Creating Internet Gateway

resource "aws_internet_gateway" "test-IG" {
  vpc_id = aws_vpc.self.id

  tags = {
    Name = "test-IG"
  }
}