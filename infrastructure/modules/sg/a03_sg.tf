resource "aws_security_group" "a03_be_sg" {
  name        = "a03_be_sg"
  description = "Allow SSH access to EC2 from home and BCIT and all traffic from pub_sg"
  vpc_id      = var.a03_vpc.id
}

resource "aws_security_group" "a03_web_sg" {
  name        = "a03_web_sg"
  description = "Allow HTTP and SSH access to EC2 from home and BCIT and all traffic from priv_sg"
  vpc_id      = var.a03_vpc.id
}

resource "aws_security_group" "a03_db_sg" {
  name        = "a03_db_sg"
  description = "Allow HTTP and SSH access to EC2 from home and BCIT and all traffic from priv_sg"
  vpc_id      = var.a03_vpc.id
}

# BE SG egress/ingress rules
resource "aws_vpc_security_group_egress_rule" "be_egress_rule" {
  security_group_id = aws_security_group.a03_be_sg.id
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name    = "be_egress_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_ssh_home_rule" {
  security_group_id = aws_security_group.a03_be_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.home_net
  tags = {
    Name    = "be_ssh_home_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_ssh_bcit_rule" {
  security_group_id = aws_security_group.a03_be_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.bcit_net
  tags = {
    Name    = "be_ssh_bcit_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_all_pub_sg_rule" {
  security_group_id = aws_security_group.a03_be_sg.id
  ip_protocol       = -1
  cidr_ipv4         = var.web_subnet_cidr
  tags = {
    Name    = "be_all_web_sg_rule"
    Project = var.project_name
  }
}

# Public SG egress/ingress rules
resource "aws_vpc_security_group_egress_rule" "web_egress_rule" {
  security_group_id = aws_security_group.a03_web_sg.id
  ip_protocol       = -1
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name    = "web_egress_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_ssh_home_rule" {
  security_group_id = aws_security_group.a03_web_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.home_net
  tags = {
    Name    = "web_ssh_home_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_ssh_bcit_rule" {
  security_group_id = aws_security_group.a03_web_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.bcit_net
  tags = {
    Name    = "web_ssh_bcit_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_http_rule" {
  security_group_id = aws_security_group.a03_web_sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name    = "web_http_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_https_rule" {
  security_group_id = aws_security_group.a03_web_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
  tags = {
    Name    = "web_https_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "all_be_sg_rule" {
  security_group_id = aws_security_group.a03_be_sg.id
  ip_protocol       = -1
  cidr_ipv4         = var.be_subnet_cidr
  tags = {
    Name    = "web_all_be_sg_rule"
    Project = var.project_name
  }
}

# DB SG egress/ingress rules
resource "aws_vpc_security_group_egress_rule" "db_egress_rule" {
  security_group_id = aws_security_group.a03_db_sg.id
  ip_protocol       = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_ipv4         = var.be_subnet_cidr
  tags = {
    Name    = "db_egress_sg_rule"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_ingress_rule" {
  security_group_id = aws_security_group.a03_db_sg.id
  ip_protocol       = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_ipv4         = var.be_subnet_cidr
  tags = {
    Name    = "db_ingress_sg_rule"
    Project = var.project_name
  }
}
