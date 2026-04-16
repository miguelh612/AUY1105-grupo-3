# VPC
resource "aws_vpc" "AUY1105-webapp-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "AUY1105-webapp-vpc"
  }
}

# Subredes

resource "aws_subnet" "AUY1105-webapp-public-subnet-1" {
  vpc_id            = aws_vpc.AUY1105-webapp-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "AUY1105-webapp-public-subnet-1"
  }
}

resource "aws_subnet" "AUY1105-webapp-public-subnet-2" {
  vpc_id            = aws_vpc.AUY1105-webapp-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "AUY1105-webapp-public-subnet-2"
  }
}

resource "aws_subnet" "AUY1105-webapp-private-subnet-1" {
  vpc_id            = aws_vpc.AUY1105-webapp-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "AUY1105-webapp-private-subnet-1"
  }
}

resource "aws_subnet" "AUY1105-webapp-private-subnet-2" {
  vpc_id            = aws_vpc.AUY1105-webapp-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "AUY1105-webapp-private-subnet-2"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "AUY1105-webapp-igw" {
  vpc_id = aws_vpc.AUY1105-webapp-vpc.id

  tags = {
    Name = "AUY1105-webapp-igw"
  }
}

# NAT Gateway

resource "aws_eip" "AUY1105-webapp-nat-eip" {
  domain = "vpc"
}

# NAT GATEWAY

resource "aws_nat_gateway" "AUY1105-webapp-nat-gw" {
  allocation_id = aws_eip.AUY1105-webapp-nat-eip.id
  subnet_id     = aws_subnet.AUY1105-webapp-public-subnet-1.id

  tags = {
    Name = "AUY1105-webapp-nat-gw"
  }

  depends_on = [aws_internet_gateway.AUY1105-webapp-igw]
}

# Tablas de enrutamiento

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.AUY1105-webapp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AUY1105-webapp-igw.id
  }

  tags = {
    Name = "AUY1105-webapp-public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.AUY1105-webapp-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.AUY1105-webapp-nat-gw.id
  }

  tags = {
    Name = "AUY1105-webapp-private-rt"
  }
}

# ASOCIACIÓN TABLAS DE ENRUTAMIENTO
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.AUY1105-webapp-public-subnet-1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.AUY1105-webapp-public-subnet-2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.AUY1105-webapp-private-subnet-1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.AUY1105-webapp-private-subnet-2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "AUY1105-webapp-sg_ec2" {
  name        = "AUY1105-webapp-sg_ec2"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.AUY1105-webapp-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["152.230.70.146/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}