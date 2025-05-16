output "documentdb_endpoint" {
  description = "The address of the DocumentDB instance"
  value       = aws_docdb_cluster.documentdb.endpoint
}