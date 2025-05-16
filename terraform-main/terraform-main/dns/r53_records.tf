resource "aws_route53_record" "rds_cname" {
  zone_id = aws_route53_zone.ss_private.zone_id
  name    = "postgres.ss.aws.local"
  type    = "CNAME"
  ttl     = 300
  records = [var.rds_address]
}

resource "aws_route53_record" "redis_cname" {
  zone_id = aws_route53_zone.ss_private.zone_id
  name    = "redis.ss.aws.local"
  type    = "CNAME"
  ttl     = 300
  records = [var.redis_endpoint]
}

resource "aws_route53_record" "documentdb_cname" {
  zone_id = aws_route53_zone.ss_private.zone_id
  name    = "docdb.ss.aws.local"
  type    = "CNAME"
  ttl     = 300
  records = [var.documentdb_endpoint]
}

# resource "aws_route53_record" "public_service_cname" {
#   for_each = toset(var.public_endpoints)
#
#   zone_id = aws_route53_zone.ss_public.zone_id
#   name    = each.value
#   type    = "CNAME"
#   ttl     = 300
#   records = [var.public_traefik_alb_dns_name]
# }

resource "aws_route53_record" "private_service_cname" {
  for_each = toset(var.private_endpoints)

  zone_id = aws_route53_zone.ss_private.zone_id
  name    = each.value
  type    = "CNAME"
  ttl     = 300
  records = [var.private_traefik_alb_dns_name]
}