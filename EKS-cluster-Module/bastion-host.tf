resource "aws_instance" "bastion_host" {
  ami                    = "ami-0be048546e3fa85c2"
  instance_type          = "t2.xlarge"
  subnet_id              = aws_subnet.public_1.id # public subnet
  key_name               = "chriskeypair"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "Bastion-Host"
  }
}
resource "aws_security_group" "bastion" {
  name        = "Bastion-host-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}