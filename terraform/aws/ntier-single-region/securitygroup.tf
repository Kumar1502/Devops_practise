resource "aws_security_group" "web" {
  vpc_id      = var.security_group_info.vpc_id
  name        = var.security_group_info.name
  description = var.security_group_info.description
  tags = {
    Name = var.security_group_info.name
  }
  depends_on = [aws_vpc.network]
}
#inbound rules
resource "aws_vpc_security_group_ingress_rule" "web" {
  security_group_id = aws_security_group.web.id
  count             = length(var.security_group_info.inbound_rules)
  cidr_ipv4         = var.security_group_info.inbound_rules[count.index].cidr
  from_port         = var.security_group_info.inbound_rules[count.index].port
  to_port           = var.security_group_info.inbound_rules[count.index].port
  ip_protocol       = var.security_group_info.inbound_rules[count.index].protocol
  description       = var.security_group_info.inbound_rules[count.index].description

  depends_on = [aws_security_group.web]
}
#outbound rules
resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  count             = length(var.security_group_info.outbound_rules)
  cidr_ipv4         = var.security_group_info.outbound_rules[count.index].cidr
  from_port         = var.security_group_info.outbound_rules[count.index].from_port
  to_port           = var.security_group_info.outbound_rules[count.index].to_port
  ip_protocol       = var.security_group_info.outbound_rules[count.index].protocol
  description       = var.security_group_info.outbound_rules[count.index].description

  depends_on = [aws_security_group.web]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  count             = var.security_group_info.allow_all_egress ? 1 : 0
  security_group_id = aws_security_group.web.id
  ip_protocol       = "-1"
  depends_on        = [aws_security_group.web]
  cidr_ipv4         = "0.0.0.0/0"
}
