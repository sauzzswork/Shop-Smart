resource "aws_eks_node_group" "node_group" {
  for_each = { for group in var.nodegroup_config : group.name => group }

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnet_ids

  ami_type        = each.value.ami_type
  capacity_type  = each.value.capacity_type

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  # launch_template {
  #   id      = aws_launch_template.eks_launch_template.id
  #   version = "$Latest"
  # }

  # remote_access {
  #   source_security_group_ids = [var.eks_nodes_sg_id]
  # }

  instance_types = [each.value.instance_type]

  labels = each.value.labels

  tags = merge(
    each.value.tags,
    {
      createdBy = "terraform"
    }
  )

  depends_on = [

    var.iam_eks_node_policy_attachment,
    var.iam_eks_cni_policy_attachment,
    var.iam_eks_registry_policy_attachment,
    var.sqs_policy_attachment

  ]
}
