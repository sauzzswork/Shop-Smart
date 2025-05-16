output "traefik_namespace" {
  description = "Traefik namespace"
  value = kubernetes_namespace.shop_smart.metadata.0.name
}

output "shopsmart_namespace" {
  description = "Shop Smart namespace"
  value = kubernetes_namespace.traefik.metadata.0.name
}

output "eks_cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value = aws_eks_cluster.main.endpoint
}

output "eks_cluster_ca_cert" {
  description = "Kubernetes cluster CA certificate"
  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "eks_cluster_token" {
  description = "Kubernetes cluster token"
  value = data.aws_eks_cluster_auth.main.token
}

output "cluster_name" {
  description = "EKS cluster name"
  value = var.cluster_name
}

# output "traefik_public_dns_name" {
#   description = "Traefik public ALB DNS name"
#   value = aws_lb.public_alb.dns_name
# }

output "traefik_private_dns_name" {
  description = "Traefik private ALB DNS name"
  value = aws_lb.private_alb.dns_name
}