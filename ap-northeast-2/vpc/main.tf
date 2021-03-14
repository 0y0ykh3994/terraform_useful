##VPC
resource "aws_vpc" "default" {
  cidr_block		= var.vpc_cidr
  enable_dns_hostnames	= true
  enable_dns_support	= true
  tags = {
    Name = "vpc.${var.resource_name}"
  }
}

##PUB Sub
resource "aws_subnet" "pub2a" {
  vpc_id		= aws_vpc.default.id
  cidr_block		= var.sub_pub2a_cidr
  availability_zone 	= "ap-northeast-2a"
  tags = {
    Name = "sub.pub2a.${var.resource_name}"
  }
}
resource "aws_subnet" "pub2c" {
  vpc_id                = aws_vpc.default.id
  cidr_block            = var.sub_pub2c_cidr
  availability_zone     = "ap-northeast-2c"
  tags = {
    Name = "sub.pub2c.${var.resource_name}"
  }
}

##PRI Sub
resource "aws_subnet" "pri2a" {
  vpc_id                = aws_vpc.default.id
  cidr_block            = var.sub_pri2a_cidr
  availability_zone     = "ap-northeast-2a"
  tags = {
    Name = "sub.pri2a.${var.resource_name}"
  }
}
resource "aws_subnet" "pri2c" {
  vpc_id                = aws_vpc.default.id
  cidr_block            = var.sub_pri2c_cidr
  availability_zone     = "ap-northeast-2c"
  tags = {
    Name = "sub.pri2c.${var.resource_name}"
  }
}

##IGW
resource "aws_internet_gateway" "default" {
  vpc_id	= aws_vpc.default.id
  tags = {
    Name = "igw.${var.resource_name}"
  }
}

##NAT GW
resource "aws_eip" "default" {
  vpc = true
  tags = {
    Name = "eip.nat.${var.resource_name}"
  }
}
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.default.id
  subnet_id = aws_subnet.pub2a.id
  tags = {
    Name = "nat.${var.resource_name}"
  }
}

##PUB RT
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }
  tags = {
    Name = "rt.pub.${var.resource_name}"
  }
}
##PRI RT
resource "aws_route_table" "pri" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.default.id
  }
  tags = {
    Name = "rt.pri.${var.resource_name}"
  }
}

resource "aws_route_table_association" "pub2a" {
  subnet_id      = aws_subnet.pub2a.id
  route_table_id = aws_route_table.pub.id
}
resource "aws_route_table_association" "pub2c" {
  subnet_id      = aws_subnet.pub2c.id
  route_table_id = aws_route_table.pub.id
}
resource "aws_route_table_association" "pri2a" {
  subnet_id      = aws_subnet.pri2a.id
  route_table_id = aws_route_table.pri.id
}
resource "aws_route_table_association" "pri2c" {
  subnet_id      = aws_subnet.pri2c.id
  route_table_id = aws_route_table.pri.id
}
