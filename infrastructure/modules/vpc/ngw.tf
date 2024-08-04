# NAT Gateway (one per AZ for high availability)
resource "aws_eip" "nat" {
  count = 2

  tags = {
    Name = "nat-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "nat-gw-${count.index}"
  }
}