output "ec2_id" {
  value = aws_instance.a03_ec2.id
}

output "ec2_pub_ip" {
  value = aws_instance.a03_ec2.public_ip
}

output "ec2_pub_dns" {
  value = aws_instance.a03_ec2.public_dns
}
