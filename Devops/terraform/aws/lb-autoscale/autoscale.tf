# Data source fro ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Launch aws template
resource "aws_launch_template" "preschool" {
  name                   = "preschool-new"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "newkeypair"
  vpc_security_group_ids = [aws_security_group.web.id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "preschool"
    }
  }
  # network_interfaces {
  #   associate_public_ip_address = true
  # }
  user_data  = filebase64("/install.sh")
  depends_on = [aws_security_group.web, data.aws_ami.ubuntu]
}

#Creatin auto scaling group
resource "aws_autoscaling_group" "preschool" {
  name             = "preschool-asg"
  desired_capacity = 2
  min_size         = 1
  max_size         = 3
  launch_template {
    id      = aws_launch_template.preschool.id
    version = "$Latest"
  }

  vpc_zone_identifier       = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]
  target_group_arns         = [aws_lb_target_group.preschool.arn]
  health_check_grace_period = 300
  health_check_type         = "EC2"
  depends_on                = [aws_subnet.public]
  force_delete              = true


}
