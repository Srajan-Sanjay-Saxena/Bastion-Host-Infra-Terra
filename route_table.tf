data "aws_subnets" "mumbai_public_subnet_ids" {
  filter {
    name = "tag:Public"
    values = [true]
  }
}

data "aws_subnets" "mumbai_private_subnet_ids" {
  filter {
    name = "tag:Public"
    values = [false]
  }
}
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
# Associate each public subnet with the public route table
resource "aws_route_table_association" "public_association" {
  for_each       = toset(data.aws_subnets.mumbai_public_subnet_ids.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}

# Associate each private subnet with the private route table (default)
resource "aws_route_table_association" "private_association" {
  for_each       = toset(data.aws_subnets.mumbai_private_subnet_ids.ids)
  subnet_id      = each.value
  route_table_id = aws_default_route_table.private_rt.id
}