variable "rds_address" {
  description = "The RDS address"
  type        = string
}

variable "redis_endpoint" {
  description = "The Redis endpoint"
  type        = string
}

variable "documentdb_endpoint" {
  description = "The DocumentDB endpoint"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

# variable "public_traefik_alb_dns_name" {
#   description = "The public traefik ALB DNS name"
#   type        = string
# }

variable "private_traefik_alb_dns_name" {
  description = "The private traefik ALB DNS name"
  type        = string
}

# variable "public_endpoints" {
#   description = "List of public ingress rules with hostnames"
#   type        = list(string)
#   default     = [
#     "central-hub.shopsmartsg.com"
#   ]
# }

variable "private_endpoints" {
  description = "List of private ingress rules with hostnames"
  type        = list(string)
  default     = [
    "profile-service.ss.aws.local",
    "product-service.ss.aws.local",
    "order-service.ss.aws.local"
  ]
}