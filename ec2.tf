resource "aws_instance" "public_mumbai_ec2" {
    for_each = toset(data.aws_subnets.mumbai_public_subnet_ids.ids)
  key_name = aws_key_pair.ssh-key.key_name
ami = "ami-0f918f7e67a3323f0"
instance_type = "t2.micro"
subnet_id = each.value
vpc_security_group_ids = [aws_security_group.standard_sg.id]
tags = {
  Name = "public_ec2_mumbai"
  Environment = "dev"
}
}
resource "aws_instance" "private_mumbai_ec2" {
    for_each = toset(data.aws_subnets.mumbai_private_subnet_ids.ids)
  key_name = aws_key_pair.ssh-key.key_name
ami = "ami-0f918f7e67a3323f0"
instance_type = "t2.micro"
subnet_id = each.value
vpc_security_group_ids = [aws_security_group.only_ssh.id]
tags = {
  Name = "private_ec2_mumbai"
  Environment = "dev"
}
}


resource "aws_key_pair" "ssh-key" {
  key_name = "terraform-testing"
  public_key = file("${path.module}/id_terraform.pub")
}

resource "aws_security_group" "standard_sg" {
  name = "standard-sg"
  description = "Allow users to ssh , send http and https request"

    dynamic "ingress" {
      for_each = [22,80,443]
      iterator = port
      content {
        description = "TLS Vpc"
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "only_ssh" {
     name = "ssh-sg"
  description = "Allow users to ssh into machine"

  ingress{
    from_port = 22
    description = "ssh-only"
    to_port = 22
    protocol = "tcp"
  }
}