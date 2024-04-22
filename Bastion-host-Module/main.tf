resource "aws_instance" "bastion_host" {
  ami                    = "ami-0be048546e3fa85c2"
  instance_type          = "t2.xlarge"
  subnet_id              = "subnet-07a8751075786251f" # public subnet
  key_name               = "chriskeypair"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "Bastion-Host"
  }
}