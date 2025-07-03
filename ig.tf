resource "aws_internet_gateway" "bastion_ig" {
  vpc_id = aws_vpc.bastion_vpc.id
  tags = {
    Name = "Bastion-IG"
  }
}