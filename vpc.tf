resource "aws_vpc" "bastion_vpc" {
  cidr_block                       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name        = "Mumbai-Vpc"
    Environment = "dev"
  }
}