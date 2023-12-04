output "be_sg_id" {
  value = aws_security_group.a03_be_sg.id
}

output "web_sg_id" {
  value = aws_security_group.a03_web_sg.id
}

output "db_sg_id" {
  value = aws_security_group.a03_db_sg.id
}

