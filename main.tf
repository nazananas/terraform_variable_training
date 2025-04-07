resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.existing_key.key_name
  subnet_id = data.aws_subnet.existing.id
  vpc_security_group_ids = [data.aws_security_group.existing.id]
  tags = {
    Name = var.name
  }
}

resource "aws_key_pair" "existing_key" {
  key_name   = "my-existing-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_subnet" "existing" {
  id = var.subnet
}

data "aws_security_group" "existing" {
  id = var.sg
}

