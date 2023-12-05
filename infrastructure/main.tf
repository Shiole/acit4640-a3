module "vpc" {
  source          = "./modules/vpc"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  be_subnet_cidr  = var.be_subnet_cidr
  web_subnet_cidr = var.web_subnet_cidr
  db1_subnet_cidr = var.db1_subnet_cidr
  db2_subnet_cidr = var.db2_subnet_cidr
  default_route   = "0.0.0.0/0"
  home_net        = var.home_net
  bcit_net        = var.bcit_net
  aws_region      = var.aws_region
  aws_az          = var.aws_az
}

module "be_sg" {
  source         = "./modules/sg"
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
      ip_protocol = "-1"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = var.vpc_cidr
      rule_name   = "be_allow_all_vpc"
    }
  ]
  egress_rules = [
    {
      description = "be allow all egress traffic"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "be_allow_all_egress"
    }
  ]
}

module "web_sg" {
  source         = "./modules/sg"
  project_name   = var.project_name
  sg_name        = "web_sg"
  sg_description = "Allow ssh & http/https traffic"
  vpc_id         = module.vpc.vpc_id
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
      ip_protocol = "-1"
      from_port   = -1
      to_port     = -1
      cidr_ipv4   = var.be_subnet_cidr
      rule_name   = "web_all_web_sg"
    }
  ]
  egress_rules = [
    {
      description = "web allow all egress traffic"
      ip_protocol = "-1"
      from_port   = 0
      to_port     = 0
      cidr_ipv4   = "0.0.0.0/0"
      rule_name   = "web_allow_all_egress"
    }
  ]
}

module "db_sg" {
  source         = "./modules/sg"
  project_name   = var.project_name
  sg_name        = "db_sg"
  sg_description = "Allows port 3306 egress & egress"
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
  source            = "./modules/ec2"
  project_name      = var.project_name
  tag_name          = "a03_be"
  aws_region        = var.aws_region
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.be_subnet_id
  security_group_id = module.be_sg.sg_id
  ssh_key_name      = var.ssh_key_name
}

module "web_ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  tag_name          = "a03_web"
  aws_region        = var.aws_region
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.web_subnet_id
  security_group_id = module.web_sg.sg_id
  ssh_key_name      = var.ssh_key_name
}

module "rds" {
  source       = "./modules/rds"
  project_name = var.project_name
  subnet_tag   = "a03_db_subnet"
  rds_tag      = "a03_rds"
  vpc_id       = var.vpc_cidr
  db_sg        = [module.sg.db_sg.sg_id]
  subnets      = [module.vpc.db1_subnet_id, module.vpc.db2_subnet_id]
}
