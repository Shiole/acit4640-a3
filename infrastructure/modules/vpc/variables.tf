variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_az" {
  description = "AWS AZ"
  type        = string
}

variable "aws_az2" {
  description = "AWS AZ 2"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "be_subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}

variable "web_subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}

variable "db1_subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}

variable "db2_subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}

variable "default_route" {
  description = "Default route"
  type        = string
}

variable "home_net" {
  description = "Home network"
  type        = string
}

variable "bcit_net" {
  description = "BCIT network"
  type        = string
}
