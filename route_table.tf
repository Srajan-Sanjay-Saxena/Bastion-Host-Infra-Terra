data "aws_subnets" "mumbai_public_subnet_ids" {
  filter {
    name   = "tag:Public"
    values = [true]
  }
}

data "aws_subnets" "mumbai_private_subnet_ids" {
  filter {
    name   = "tag:Public"
    values = [false]
  }
}
resource "aws_route_table" "private_rt" {
  count  = length(toset(data.aws_subnets.mumbai_private_subnet_ids.ids))
  vpc_id = aws_vpc.bastion_vpc
  tags = {
    Name = "private-route-table-${count.index}"
  }
}
resource "aws_default_route_table" "default_public_rt" {
    default_route_table_id = aws_vpc.bastion_vpc.main_route_table_id
  tags = {
    Name = "public-rt"
  }
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bastion_ig.id
}
route {
    cidr_block = local.vpc_cidr_block
    gateway_id = "local"

}
}
# Associate each public subnet with the public route table
# without adding depends_on i was not getting explicit association of subnets
resource "aws_route_table_association" "public_association" {
  depends_on     = [aws_subnet.subnets]
  for_each       = toset(data.aws_subnets.mumbai_public_subnet_ids.ids)
  subnet_id      = each.value
  route_table_id = aws_default_route_table.default_public_rt.id
}

# Associate each private subnet with the private route table (default)
resource "aws_route_table_association" "private_association" {
  depends_on     = [aws_subnet.subnets]
  for_each       = toset(data.aws_subnets.mumbai_private_subnet_ids.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rt
}