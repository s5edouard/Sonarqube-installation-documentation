resource "aws_security_group" "bastion" {
  name        = "Bastion-host-sg"
  description = "Security group for bastion host"
  vpc_id      = "vpc-01b01af346d67136f"

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