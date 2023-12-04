variable "project_name" {
  description = "Project name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "tag_name" {
  description = "Tag name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "subnet_id" {
  description = "The subnet to launch the instance on"
  type        = string
}

variable "security_group_id" {
  description = "The security group to launch the instance in"
  type        = string
}

variable "ssh_key_name" {
  description = "AWS SSH key name"
  type        = string
}

provider "aws" {
  region = var.aws_region
}
