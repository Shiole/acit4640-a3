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
