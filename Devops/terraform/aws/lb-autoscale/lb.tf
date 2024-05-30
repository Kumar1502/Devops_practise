# Create network load balancer
resource "aws_lb" "preschool" {
  name               = "preschool-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  # subnet_mapping {
  #   subnet_id = aws_subnet.public[0].id
  # }
  security_groups = [aws_security_group.web.id]


}
#Create Lb target group
resource "aws_lb_target_group" "preschool" {
  name        = "preschool-tg"
  port        = 80
  protocol    = "TCP" #"HTTP"
  vpc_id      = aws_vpc.ntier.id
  target_type = "instance"
  target_health_state {
    enable_unhealthy_connection_termination = true

  }
  health_check {
    enabled             = true
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    path                = "/"
    protocol            = "HTTP"
    port                = 80
    #matcher             = "200"
    timeout = 5
  }

}

#Create Lb listener
resource "aws_lb_listener" "preschool" {
  port     = local.http
  protocol = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.preschool.arn

  }
  load_balancer_arn = aws_lb.preschool.arn

}
