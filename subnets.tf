resource "aws_subnet" "subnets" {
  for_each = local.subnets_data
  vpc_id = each.value.vpc_id
  cidr_block = each.value.subnet_cidr
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
}