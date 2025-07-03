resource "aws_eip" "nat_eips" {
  count = length(toset(data.aws_subnets.mumbai_public_subnet_ids.ids))
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  count         = length(toset(data.aws_subnets.mumbai_public_subnet_ids.ids))
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = data.aws_subnets.mumbai_public_subnet_ids.ids[count.index]
  tags = {
    Name = "nat-gateway-${count.index}"
  }
}
