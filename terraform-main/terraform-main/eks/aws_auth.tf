resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
- rolearn: ${var.eks_node_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
    - system:authenticated
YAML

    mapUsers = <<YAML
- userarn: arn:aws:iam::528757829228:user/cli-role
  username: sasmit@shopsmartsg
  groups:
    - system:masters
YAML
  }
}

# resource "kubernetes_manifest" "aws_auth" {
#   manifest = {
#     apiVersion = "v1"
#     kind       = "ConfigMap"
#     metadata = {
#       name      = "aws-auth"
#       namespace = "kube-system"
#     }
#     data = {
#       mapRoles = <<YAML
# - rolearn: ${var.eks_node_role_arn}
#   username: system:node:{{EC2PrivateDNSName}}
#   groups:
#     - system:bootstrappers
#     - system:nodes
#     - system:authenticated
# YAML
#
#       mapUsers = <<YAML
# - userarn: arn:aws:iam::343218220772:user/sasmit@shopsmartsg
#   username: sasmit@shopsmartsg
#   groups:
#     - system:masters
# - userarn: arn:aws:iam::343218220772:user/simran@shopsmartsg
#   username: simran@shopsmartsg
#   groups:
#     - system:masters
# YAML
#     }
#   }
# }