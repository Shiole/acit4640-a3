resource "aws_instance" "a03_ec2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ssh_key_name
  subnet_id       = var.subnet.id
  security_groups = [var.security_group_id]
  tags = {
    Name    = var.tag_name
    Project = var.project_name
    Type    = "web"
  }
}
