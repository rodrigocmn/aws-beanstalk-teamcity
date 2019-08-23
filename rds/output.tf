# RDS DB instance identifier.
output "rds_id" {
  value = aws_db_instance.rds_instance.id
}

# Address of the RDS DB instance.
output "rds_address" {
  value = aws_db_instance.rds_instance.address
}

# Database port
output "rds_port" {
  value = aws_db_instance.rds_instance.port
}