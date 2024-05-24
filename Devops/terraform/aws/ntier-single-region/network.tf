# Creation of Vpc
resource "aws_vpc" "network" {

  cidr_block = var.network_info.cidr_range
  tags = {
    Name = var.network_info.name
  }
}
# Creation of private subnets
resource "aws_subnet" "private" {

  vpc_id            = aws_vpc.network.id
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index].subnet_cidr
  availability_zone = var.private_subnets[count.index].az
  tags = {
    Name = var.private_subnets[count.index].name
  }
  depends_on = [aws_vpc.network]

}
# Creation of public subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.network.id
  count             = length((var.public_subnets))
  cidr_block        = var.public_subnets[count.index].subnet_cidr
  availability_zone = var.public_subnets[count.index].az
  tags = {
    Name = var.public_subnets[count.index].name
  }
  depends_on = [aws_vpc.network]
}

# Creation of internet gateway

resource "aws_internet_gateway" "ntier" {
  vpc_id = aws_vpc.network.id
  tags = {
    Name = "ntier"
  }

  depends_on = [aws_vpc.network]
}

# Creation of Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ntier.id
  }
  depends_on = [aws_internet_gateway.ntier, aws_vpc.network]
}
# Association between route table and subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [aws_subnet.public, aws_route_table.public]

}