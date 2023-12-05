output "rds_id" {
  value = aws_db_instance.a03_rds.id
}

output "rds_address" {
  value = aws_db_instance.a03_rds.endpoint
}

output "rds_port" {
  value = aws_db_instance.a03_rds.port
}

output "rds_user" {
  value = aws_db_instance.a03_rds.username
}
