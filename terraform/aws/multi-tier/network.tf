resource "aws_vpc" "primary" {
  cidr_block = var.primary_network_cidr
  tags = {
    name = "primary"
  }
}

resource "aws_subnet" "subnets" {

  count             = length(var.subnet_names)
  vpc_id            = aws_vpc.primary.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.subnet_cidrs[count.index]
  tags = {
    Name        = var.subnet_names[count.index]
    cratedBy    = "terraform"
    Environment = "Dev"
  }
  depends_on = [aws_vpc.primary]
}
 