# data "aws_subnet" "public_subnets" {
#   ids = var.public_subnet_ids
# }
#
# data "aws_subnet" "private_subnets" {
#   id = var.private_subnet_ids
# }

# data "aws_iam_role" "eks_cluster_iam_role" {
#   arn = var.eks_cluster_role_arn
#   name = var.eks_cluster_role_name
# }

# data "aws_iam_role" "eks_node_iam_role" {
#   arn = var.eks_node_role_arn
#   name = var.eks_node_role_name
# }

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids = concat(
      var.public_subnet_ids,
      var.private_subnet_ids
    )
    security_group_ids = [var.eks_sg_id]
  }

  version = "1.29"

  tags = {
    Name = var.cluster_name
  }

  depends_on = [

    var.iam_eks_cluster_policy_attachment

  ]
}

provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.main.token
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}