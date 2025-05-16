# resource "aws_route53_zone" "ss_public" {
#   name = "shopsmartsg.com"
#   # As registered domain was manually created so it created a new public hosted zone for the same
#   # being maintain through : hosted r53 zone : Z0972505QJQMVZWORCSI
#   # use terraform import module.dns.aws_route53_zone.ss_public Z0972505QJQMVZWORCSI
# }

resource "aws_route53_zone" "ss_private" {
  name = "ss.aws.local"
  vpc {
    vpc_id = var.vpc_id  # Replace with your VPC ID
  }
}