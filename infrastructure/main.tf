module "vpc" {
  source          = "./infrastructure/modules/ec2"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  be_subnet_cidr  = var.be_subnet_cidr
  web_subnet_cidr = var.web_subnet_cidr
  db1_subnet_cidr = var.db1_subnet_cidr
  db2_subnet_cidr = var.db2_subnet_cidr
  home_net        = var.home_net
  aws_region      = var.aws_region
  aws_az          = var.aws_az
}

module "sg" {
  source         = "./infrastructure/modules/sg"
  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
  home_net       = var.home_net
  bcit_net       = var.bcit_net
  be_subnet_cidr = var.be_subnet_cidr
}

module "be_ec2" {
  source            = "./infrastructure/modules/ec2"
  project_name      = var.project_name
  instance_type     = var.instance_type
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
  instance_type     = var.instance_type
  tag_name          = "a03_web"
  aws_region        = var.aws_region
  ami_id            = var.ami_id
  subnet_id         = module.vpc.web_subnet_id
  security_group_id = module.sg.web_sg_id
  ssh_key_name      = var.ssh_key_name
}
