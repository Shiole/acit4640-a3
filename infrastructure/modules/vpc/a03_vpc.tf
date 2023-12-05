terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "a03_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name    = "a03_vpc"
    Project = var.project_name
  }
}

resource "aws_subnet" "a03_be_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.be_subnet_cidr
  availability_zone       = var.aws_az
  map_public_ip_on_launch = true
  tags = {
    Name    = "a03_be_subnet"
    Project = var.project_name
  }
}

resource "aws_subnet" "a03_web_subnet" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.web_subnet_cidr
  availability_zone       = var.aws_az
  map_public_ip_on_launch = true
  tags = {
    Name    = "a03_web_subnet"
    Project = var.project_name
  }
}

resource "aws_db_subnet_group" "a03_db_subnet" {
  name       = "a03_db_subnet"
  vpc_id     = aws_vpc.a03_vpc.id
  subnet_ids = [var.db1_subnet_cidr, var.var.db2_subnet_cidr]
  tags = {
    Name    = "a03_db_subnet"
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "a03_gw" {
  vpc_id = aws_vpc.a03_vpc.id
  tags = {
    Name    = "a03_gw"
    Project = var.project_name
  }
}

resource "aws_route_table" "a03_rt" {
  vpc_id = aws_vpc.a03_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.a03_gw.id
  }

  tags = {
    Name    = "a03_rt"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "a03_priv_rt_assoc" {
  subnet_id      = aws_subnet.a03_be_subnet.id
  route_table_id = aws_route_table.a03_rt.id
}

resource "aws_route_table_association" "a03_pub_rt_assoc" {
  subnet_id      = aws_subnet.a03_web_subnet.id
  route_table_id = aws_route_table.a03_rt.id
}
