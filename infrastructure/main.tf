module "vpc" {
  source          = "./infrastructure/modules/ec2"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  be_subnet_cidr  = var.be_subnet_cidr
  web_subnet_cidr = var.web_subnet_cidr
  db1_subnet_cidr = var.db1_subnet_cidr
  db2_subnet_cidr = var.db2_subnet_cidr
  default_route   = "0.0.0.0/0"
  home_net        = var.home_net
  aws_region      = var.aws_region
  aws_az          = var.aws_az
}

module "be_sg" {
  source         = "./infrastructure/modules/sg"
  project_name   = var.project_name
  sg_name        = "be_sg"
  sg_description = "Allow ssh & all traffic from vpc"
  vpc_id         = module.vpc.vpc_id
  ingress_rules = [
    {
      description = "be ssh from home"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.home_net
      rule_name   = "be_ssh_home"
    },
    {
      description = "be ssh from bcit"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.bcit_net
      rule_name   = "be_ssh_bcit"
    },
    {
      description = "be allow all vpc"
      ip_protocol = -1
      cidr_ipv4   = var.vpc_cidr
      rule_name   = "be_allow_all_vpc"
    }
  ]
  egress_rules = [
    {
      description = "allow all egress traffic"
      ip_protocol = -1
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "allow_all_egress"
    }
  ]
}

module "web_sg" {
  source       = "./infrastructure/modules/sg"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      description = "web ssh from home"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.home_net
      rule_name   = "web_ssh_home"
    },
    {
      description = "web ssh from bcit"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = var.bcit_net
      rule_name   = "web_ssh_bcit"
    },
    {
      description = "web allow http"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "web_allow_http"
    },
    {
      description = "web allow https"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "web_allow_https"
    },
    {
      description = "web allow be sg"
      ip_protocol = -1
      cidr_ipv4   = module.be_subnet_cidr
      rule_name   = "web_all_web_sg"
    }
  ]
  egress_rules = [
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "allow_all_egress"
    }
  ]
}

module "db_sg" {
  source         = "./infrastructure/modules/sg"
  sg_description = "Allows ssh, web, and port 5000 ingress access and all egress"
  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  ingress_rules = [
    {
      description = "be access port 3306"
      ip_protocol = "tcp"
      from_port   = 3306
      to_port     = 3306
      cidr_ipv4   = var.be_subnet_cidr
      rule_name   = "be_access_3306"
    }
  ]
  egress_rules = [
    {
      description = "allow be egress traffic"
      ip_protocol = "-1"
      from_port   = 3306
      to_port     = 3306
      cidr_ipv4   = var.be_subnet_cidr
      rule_name   = "allow_be_egress"
    }
  ]
}

module "be_ec2" {
  source            = "./infrastructure/modules/ec2"
  project_name      = var.project_name
  tag_name          = "a03_be"
  aws_region        = var.aws_region
  ami_id            = var.ami_id
  subnet_id         = module.vpc.be_subnet_id
  security_group_id = module.sg.be_sg_id
  ssh_key_name      = var.ssh_key_name
}

module "web_ec2" {
  source            = "./infrastructure/modules/ec2"
  project_name      = var.project_name
  tag_name          = "a03_web"
  aws_region        = var.aws_region
  ami_id            = var.ami_id
  subnet_id         = module.vpc.web_subnet_id
  security_group_id = module.sg.web_sg_id
  ssh_key_name      = var.ssh_key_name
}
