# VPC

resource "aws_vpc" "demovpc" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "learnvpc"
  }
}


# AVAILABLE AVAILABILITY ZONES

data "aws_availability_zones" "available" {
  state = "available"
}


# PUBLIC SUBNET 1

resource "aws_subnet" "pub-subnet-1" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "11.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 1"
  }
}


# PUBLIC SUBNET 2

resource "aws_subnet" "pub-subnet-2" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block              = "11.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public subnet 2"
  }
}


# INTERNET GATEWAY

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "internet_gateway"
  }
}


# ROUTE TABLE

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "public route table"
  }
}


# ROUTE TABLE ASSOCIATION - SUBNET 1

resource "aws_route_table_association" "route-association-1" {
  subnet_id      = aws_subnet.pub-subnet-1.id
  route_table_id = aws_route_table.route-table.id
}


# ROUTE TABLE ASSOCIATION - SUBNET 2

resource "aws_route_table_association" "route-association-2" {
  subnet_id      = aws_subnet.pub-subnet-2.id
  route_table_id = aws_route_table.route-table.id
}
