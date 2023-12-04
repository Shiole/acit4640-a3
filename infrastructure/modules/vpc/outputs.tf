output "vpc_id" {
  value = aws_vpc.a03_vpc.id
}

output "be_subnet_id" {
  value = aws_subnet.a03_be_subnet.id
}

output "web_subnet_id" {
  value = aws_subnet.a03_web_subnet.id
}

output "db1_subnet_id" {
  value = aws_subnet.a03_db1_subnet.id
}

output "db2_subnet_id" {
  value = aws_subnet.a03_db2_subnet.id
}

output "a03_gw_id" {
  value = aws_internet_gateway.a03_gw.id
}

output "a03_rt_id" {
  value = aws_route_table.a03_rt.id
}
