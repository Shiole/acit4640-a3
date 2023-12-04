variable "aws_region" {
  description = "AWS region"
}

variable "aws_az" {
  description = "AWS AZ"
}

variable "project_name" {
  description = "Project name"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
}

variable "be_subnet_cidr" {
  description = "Subnet CIDR"
}

variable "web_subnet_cidr" {
  description = "Subnet CIDR"
}

variable "db1_subnet_cidr" {
  description = "Subnet CIDR"
}

variable "db2_subnet_cidr" {
  description = "Subnet CIDR"
}

variable "default_route" {
  description = "Default route"
  default     = "0.0.0.0/0"
}

variable "home_net" {
  description = "Home network"
}

variable "bcit_net" {
  description = "BCIT network"
}
