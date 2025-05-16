resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"  # Low-cost instance type
  num_cache_nodes      = 1
  # parameter_group_name = "default.redis3.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.default.name
  security_group_ids   = [aws_security_group.redis_sg.id]
}

# resource "aws_route53_record" "redis_cname" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "redis.ss.aws.com"
#   type    = "CNAME"
#   ttl     = 300
#   records = [aws_elasticache_cluster.redis.cache_nodes.0.address]
# }