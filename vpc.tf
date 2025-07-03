resource "aws_vpc" "bastion-aws_vpc" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name = "Mumbai-Vpc"
    Environment = "dev"
  }
}