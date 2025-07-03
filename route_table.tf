resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc. bastion_vpc.main_route_table_id
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bastion_vpc.id
  tags = {
    Name = "public-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bastion_ig.id
  }
}