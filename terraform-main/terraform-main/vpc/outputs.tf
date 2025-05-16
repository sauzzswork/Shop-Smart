output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "main_vpc_id" {
  description = "Main VPC Id"
  value = aws_vpc.main.id
}

output "main_vpc_cidr_block" {
  description = "Main VPC CIDR Block"
  value = aws_vpc.main.cidr_block
}

output "eks_cluster_sg_id" {
  description = "EKS Cluster Security Group ID"
  value = aws_security_group.eks_cluster_sg.id
}

output "eks_node_sg_id" {
  description = "EKS Node Security Group ID"
  value = aws_security_group.eks_node_sg.id
}

output "alb_public_sg_id" {
  description = "Public ALB Security Group ID"
  value = aws_security_group.public_alb_sg.id
}

output "alb_private_sg_id" {
  description = "Private ALB Security Group ID"
  value = aws_security_group.private_alb_sg.id
}