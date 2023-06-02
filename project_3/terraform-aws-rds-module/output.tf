output "rds_address" {
  value = aws_db_instance.db_instance.endpoint
}