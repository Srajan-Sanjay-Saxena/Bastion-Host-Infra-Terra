locals {
  vpc_cidr_block = aws_vpc.bastion_vpc.cidr_block
  subnets_data = {
    for idx, info in var.mumbai_subnets :
    "subnet-${info.availability_zone}" =>
    {
      availability_zone       = info.availability_zone
      map_public_ip_on_launch = info.is_public
      vpc_id                  = aws_vpc.bastion_vpc.id
      vpc_cidr_block          = local.vpc_cidr_block
      subnet_cidr             = "${join(".", slice(split(".", split("/", local.vpc_cidr_block)[0]), 0, 2))}.${idx + 1}.0/24"
    }

  }

  public_subnet_map = {
    for idx, subnet_id in data.aws_subnets.mumbai_public_subnet_ids.ids :
    "subnet-${idx}" => subnet_id
  }
  private_subnet_map = {
    for idx, subnet_id in data.aws_subnets.mumbai_private_subnet_ids.ids :
    "subnet-${idx}" => subnet_id
  }
}