variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_az" {
  description = "AWS AZ"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "sg_name" {
  description = "SG name"
  type        = string
}

variable "sg_description" {
  description = "SG description"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "ingress_rules" {
  description = "SG ingress rules list"
  type        = list(map(string))
}

variable "egress_rules" {
  description = "SG egress rules list"
  type        = list(map(string))
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
