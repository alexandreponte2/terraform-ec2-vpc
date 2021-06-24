resource "aws_vpc" "vpc_webserver" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = var.resource_tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_webserver.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags                    = var.resource_tags

}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc_webserver.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"
  tags                    = var.resource_tags

}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc_webserver.id

  tags = {
    Name = "internet-gw"
  }
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc_webserver.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.internet-gw]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc_webserver.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}

resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private-rt.id
}