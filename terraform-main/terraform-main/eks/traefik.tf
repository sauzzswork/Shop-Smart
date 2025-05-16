provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
    # token                  = data.aws_eks_cluster_auth.cluster_auth.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

# resource "helm_release" "traefik-public" {
#   name       = "traefik-public"
#   namespace  = kubernetes_namespace.traefik.metadata[0].name
#   repository = "https://traefik.github.io/charts"
#   chart      = "traefik"
#   cleanup_on_fail = true
#
#   values = [
#     <<EOF
# service:
#   externalTrafficPolicy: "Cluster"
#   annotations:
#     service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
#     service.beta.kubernetes.io/aws-load-balancer-type: alb
#     alb.ingress.kubernetes.io/scheme: internet-facing
#     alb.ingress.kubernetes.io/target-type: ip
#     alb.ingress.kubernetes.io/backend-protocol: HTTP
#   name: traefik-public
# ingressClass:
#   enabled: true
#   isDefaultClass: false
#   name: traefik-public
# affinity:
#   nodeAffinity:
#     requiredDuringSchedulingIgnoredDuringExecution:
#       nodeSelectorTerms:
#       - matchExpressions:
#         - key: "ng_id"
#           operator: In
#           values:
#           - "ss-traefik"
# tolerations:
# - key: "dedicated"
#   operator: "Equal"
#   value: "traefik"
#   effect: "NoSchedule"
# EOF
#   ]
#   # timeout = 600 # Increase the timeout to 10 minutes
# }
#
# resource "helm_release" "traefik-private" {
#   name       = "traefik-private"
#   namespace  = kubernetes_namespace.traefik.metadata[0].name
#   repository = "https://traefik.github.io/charts"
#   chart      = "traefik"
#   cleanup_on_fail = true
#
#   values = [
#     <<EOF
# service:
#   externalTrafficPolicy: "Cluster"
#   annotations:
#     service.beta.kubernetes.io/aws-load-balancer-scheme: internal
#     service.beta.kubernetes.io/aws-load-balancer-type: alb
#     alb.ingress.kubernetes.io/scheme: internal
#     alb.ingress.kubernetes.io/target-type: ip
#     alb.ingress.kubernetes.io/backend-protocol: HTTP
#   name: traefik-private
# ingressClass:
#   enabled: true
#   isDefaultClass: false
#   name: traefik-private
# affinity:
#   nodeAffinity:
#     requiredDuringSchedulingIgnoredDuringExecution:
#       nodeSelectorTerms:
#       - matchExpressions:
#         - key: "ng_id"
#           operator: In
#           values:
#           - "ss-traefik"
# tolerations:
# - key: "dedicated"
#   operator: "Equal"
#   value: "traefik"
#   effect: "NoSchedule"
# EOF
#   ]
#   # timeout = 600 # Increase the timeout to 10 minutes
# }


# resource "helm_release" "traefik-public" {
#   name       = "traefik-public"
#   namespace  = kubernetes_namespace.traefik.metadata[0].name
#   repository = "https://traefik.github.io/charts"
#   chart      = "traefik"
#   cleanup_on_fail = true
#
#   values = [
#     <<EOF
# service:
#   type: "ClusterIP"
#   annotations:
#     service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
#     alb.ingress.kubernetes.io/scheme: internet-facing
#     alb.ingress.kubernetes.io/target-type: ip
#     alb.ingress.kubernetes.io/backend-protocol: HTTP
#   name: traefik-public
# ingressClass:
#   enabled: true
#   isDefaultClass: false
#   name: traefik-public
# affinity:
#   nodeAffinity:
#     requiredDuringSchedulingIgnoredDuringExecution:
#       nodeSelectorTerms:
#       - matchExpressions:
#         - key: "ng_id"
#           operator: In
#           values:
#           - "ss-traefik"
# tolerations:
# - key: "dedicated"
#   operator: "Equal"
#   value: "traefik"
#   effect: "NoSchedule"
# EOF
#   ]
#   # timeout = 600 # Increase the timeout to 10 minutes
# }

resource "helm_release" "traefik-private" {
  name       = "traefik-private"
  namespace  = kubernetes_namespace.traefik.metadata[0].name
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  cleanup_on_fail = true

  values = [
    <<EOF
service:
  type: "ClusterIP"
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-scheme: internal
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/backend-protocol: HTTP
  name: traefik-private
ingressClass:
  enabled: true
  isDefaultClass: false
  name: traefik-private
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "ng_id"
          operator: In
          values:
          - "ss-traefik"
tolerations:
- key: "dedicated"
  operator: "Equal"
  value: "traefik"
  effect: "NoSchedule"
EOF
  ]
  # timeout = 600 # Increase the timeout to 10 minutes
}