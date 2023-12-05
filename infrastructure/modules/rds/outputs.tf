output "rds_endpoint" {
  value = aws_db_instance.a03_rds.endpoint
}

output "rds_address" {
  value = aws_db_instance.a03_rds.address
}
