resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = data.aws_key_pair.existing_key.key_name
  subnet_id = data.aws_subnet.existing.id
  vpc_security_group_ids = [data.aws_security_group.existing.id]
  tags = {
    Name = var.name
  }
}

data "aws_key_pair" "existing_key" {
  key_name = "my-existing-key"
}

resource "aws_ebs_volume" "web_storage" {
  availability_zone = data.aws_subnet.existing.availability_zone
  size              = var.storage_size
  type              = var.storage_type
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_storage.id
  instance_id = aws_instance.web.id
}

data "aws_subnet" "existing" {
  id = var.subnet
}

data "aws_security_group" "existing" {
  id = var.sg
}

