resource "aws_instance" "web" {
  ami                         = var.web_instance_info.ami
  instance_type               = var.web_instance_info.size
  key_name                    = var.web_instance_info.key_name
  subnet_id                   = ""
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true
  tags = {
    Name = var.web_instance_info.name
  }
  user_data = file("install.sh")

  depends_on = [aws_security_group.web, aws_subnet.public, aws_subnet.private]

}
