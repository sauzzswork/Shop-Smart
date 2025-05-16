# resource "aws_acm_certificate" "ss_aws_cert" {
#   domain_name       = "*.shopsmartsg.com"
#   subject_alternative_names = ["*.shopsmartsg.com"]
#   validation_method = "DNS"
#
#   tags = {
#     Name = "ss-aws-public-cert"
#   }
# }
#
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.ss_aws_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }
#
#   zone_id = var.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
#
#   # Ensure the DNS validation record is created before the certificate is validated
#   depends_on = [aws_acm_certificate.ss_aws_cert]
# }
# #
# resource "aws_acm_certificate_validation" "ss_aws_cert_validation" {
#   certificate_arn = aws_acm_certificate.ss_aws_cert.arn
#
#   validation_record_fqdns = [
#     for r in aws_route53_record.cert_validation : r.fqdn
#   ]
# }