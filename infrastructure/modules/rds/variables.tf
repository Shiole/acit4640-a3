variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "db_sg" {
  description = "AWS RDS SG"
  type        = list(string)
}

variable "subnets" {
  description = "RDS subnet group"
  type        = list(string)
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "subnet_tag" {
  description = "Subnet tag name"
  type        = string
}

variable "rds_tag" {
  description = "RDS tag name"
  type        = string
}
