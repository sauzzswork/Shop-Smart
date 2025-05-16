# resource "aws_launch_template" "eks_launch_template" {
#   name_prefix   = "eks-node-"
#   image_id      = "ami-0ad522a4a529e7aa8"
#
#   network_interfaces {
#     security_groups = [var.eks_nodes_sg_id]
#   }
#
#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "EKS Node"
#       createdBy = "terraform"
#     }
#   }
# }
