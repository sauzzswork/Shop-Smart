output "postgres_address" {
  description = "The address of the RDS Postgres instance"
  value       = aws_db_instance.postgres.address
}