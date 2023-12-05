variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "aws_az" {
  description = "AWS AZ"
  default     = "us-west-2a"
}

variable "aws_az2" {
  description = "AWS AZ 2"
  default     = "us-west-2b"
}

variable "project_name" {
  description = "Project name"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "192.168.0.0/16"
}

variable "be_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.1.0/24"
}

variable "web_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.2.0/24"
}

variable "db1_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.3.0/24"
}

variable "db2_subnet_cidr" {
  description = "Subnet CIDR"
  default     = "192.168.4.0/24"
}

variable "default_route" {
  description = "Default route"
  default     = "0.0.0.0/0"
}

variable "home_net" {
  description = "Home network"
  default     = "24.80.22.0/24"
}

variable "bcit_net" {
  description = "BCIT network"
  default     = "142.232.0.0/16"
}

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-04203cad30ceb4a0c"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "AWS SSH key name"
  default     = "acit_4640"
}
