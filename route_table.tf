resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bastion_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
  }
}