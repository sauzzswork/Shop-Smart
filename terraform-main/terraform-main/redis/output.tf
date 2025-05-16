output "redis_endpoint" {
  description = "The endpoint of the RDS Postgres instance"
  value       = aws_elasticache_cluster.redis.cache_nodes.0.address
}