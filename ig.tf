resource "aws_internet_gateway" "bastion_ig" {
  depends_on = [aws_vpc.bastion_vpc]
  vpc_id     = aws_vpc.bastion_vpc.id
  tags = {
    Name = "Bastion-IG"
  }
}