#Creating vpc
resource "aws_vpc" "ntier" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "ntier"
  }

}

# Creating public subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.ntier.id
  count             = length(var.public_subnets_info)
  cidr_block        = var.public_subnets_info[count.index].cidr
  availability_zone = var.public_subnets_info[count.index].availability_zone
  tags = {
    Name = var.public_subnets_info[count.index].name
  }

  depends_on = [aws_vpc.ntier]

}
# Creating public subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.ntier.id
  count             = length(var.private_subnets_info)
  cidr_block        = var.private_subnets_info[count.index].cidr
  availability_zone = var.public_subnets_info[count.index].availability_zone
  tags = {
    Name = var.private_subnets_info[count.index].name
  }

  depends_on = [aws_vpc.ntier]

}
#Create internet gateway
resource "aws_internet_gateway" "ntier" {
  vpc_id = aws_vpc.ntier.id

  depends_on = [aws_vpc.ntier]

}
#create route table
resource "aws_route_table" "preschool" {
  vpc_id = aws_vpc.ntier.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ntier.id
  }

  depends_on = [aws_vpc.ntier]
}
#Associate route table with public subnets
resource "aws_route_table_association" "preschool" {
  count          = length(var.public_subnets_info)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.preschool.id

  depends_on = [aws_subnet.public]
}
# Create security group
resource "aws_security_group" "web" {
  name        = "web-sg-new"
  description = "It allows inbound traffic port 80 and 22"

  vpc_id = aws_vpc.ntier.id

  ingress {

    from_port        = local.http
    to_port          = local.http
    protocol         = local.tcp
    description      = "this is used to acces from http"
    cidr_blocks      = [local.any_ipv4]
    ipv6_cidr_blocks = [local.any_ipv6]

  }
  ingress {

    from_port        = local.ssh
    to_port          = local.ssh
    protocol         = local.tcp
    description      = "this is used to acces from ssh"
    cidr_blocks      = [local.any_ipv4]
    ipv6_cidr_blocks = [local.any_ipv6]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
  tags = {

    Environment = "dev"
    Name        = "ntier-web"
  }
  depends_on = [aws_vpc.ntier]
}
