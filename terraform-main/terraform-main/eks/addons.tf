# resource "aws_eks_addon" "cloudwatch_observability" {
#   cluster_name    = aws_eks_cluster.main.name
#   addon_name      = "amazon-cloudwatch-observability"
#   resolve_conflicts_on_update = "OVERWRITE" # Optional: to manage conflicts automatically
#   tags = {
#     Name = "cloudwatch-observability"
#   }
# }
