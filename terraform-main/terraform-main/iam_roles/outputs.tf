output "eks_cluster_role_arn" {
  description = "The ARN of the EKS cluster role"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "The ARN of the EKS node role"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_cluster_role_name" {
  description = "The Name of the EKS cluster role"
  value       = aws_iam_role.eks_cluster_role.name
}

output "eks_node_role_name" {
  description = "The Name of the EKS node role"
  value       = aws_iam_role.eks_node_role.name
}

output "iam_eks_cluster_policy_attachment" {
  description = "Cluster policy role attachment"
  value = aws_iam_role_policy_attachment.eks_cluster_policy
}

output "iam_eks_node_policy_attachment" {
  description = "Node policy role attachment"
  value = aws_iam_role_policy_attachment.eks_node_policy
}

output "iam_eks_cni_policy_attachment" {
  description = "CNI policy role attachment"
  value = aws_iam_role_policy_attachment.eks_cni_policy
}

output "iam_eks_registry_policy_attachment" {
  description = "Registry Policy role attachment"
  value = aws_iam_role_policy_attachment.eks_registry_policy
}

output "iam_sqs_policy_attachment" {
  description = "SQS Policy Attachment"
  value = aws_iam_role_policy_attachment.sqs_policy_attachment
}