resource "aws_db_subnet_group" "a03_db_subnet" {
  name       = "a03_db_subnet"
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets
  tags = {
    Name    = var.subnet_tag
    Project = var.project_name
  }
}

resource "aws_db_instance" "a03_rds" {
  identifier             = "a03_db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  db_name                = "mydb"
  engine                 = "mysql"
  username               = "admin"
  password               = "password"
  vpc_security_group_ids = var.db_sg
  db_subnet_group_name   = aws_db_subnet_group.a03_db_subnet.id
  skip_final_snapshot    = true
  publicly_accessible    = true
  tags = {
    Name    = var.rds_tag
    Project = var.project_name
  }
}
