# output "public_zone_id" {
#   description = "The Route 53 hosted zone ID"
#   value       = aws_route53_zone.ss_public.zone_id
# }

output "private_zone_id" {
  description = "The Route 53 private hosted zone ID"
  value       = aws_route53_zone.ss_private.zone_id
}