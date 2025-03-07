resource "aws_vpc" "dlr_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "dlr_igw" {
  vpc_id = aws_vpc.dlr_vpc.id

  tags = {
    Name = "dlr_igw"
  }
}

resource "aws_subnet" "dlr_public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.dlr_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "dlr_public_subnet-${count.index}"
  }
}

resource "aws_subnet" "dlr_private_subnet" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.dlr_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "dlr_private_subnet-${count.index}"
  }
}

resource "aws_route_table" "dlr_vpc_rt" {
  vpc_id = aws_vpc.dlr_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dlr_igw.id
  }

  tags = {
    Name = "dlr_vpc_rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.dlr_public_subnet)
  subnet_id      = aws_subnet.dlr_public_subnet[count.index].id
  route_table_id = aws_route_table.dlr_vpc_rt.id
}

