variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "shopsmart-eks-cluster"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type = list(string)
}

variable "eks_cluster_role_arn" {
  description = "ARN of EKS cluster IAM role"
  type = string
}

variable "eks_cluster_role_name" {
  description = "Name of EKS cluster IAM role"
  type = string
}

variable "eks_node_role_arn" {
  description = "ARN of EKS Node IAM role"
  type = string
}

variable "eks_node_role_name" {
  description = "Name of EKS Node IAM role"
  type = string
}

variable "vpc_main_id" {
  description = "AWS VPC Main Id"
  type = string
}
variable "vpc_main_cidr_block" {
  description = "AWS VPC Main CIDR Block"
  type = string
}

variable "iam_eks_cluster_policy_attachment" {
  description = "AWS IAM EKS Cluster policy attachment"
  type = string
}
variable "iam_eks_node_policy_attachment" {
  description = "AWS IAM EKS Node policy attachment"
  type = string
}
variable "iam_eks_cni_policy_attachment" {
  description = "AWS IAM EKS CNI policy attachment"
  type = string
}
variable "iam_eks_registry_policy_attachment" {
  description = "AWS IAM EKS Registry policy attachment"
  type = string
}
variable "sqs_policy_attachment" {
    description = "SQS Policy Attachment"
    type = string
}


variable "eks_sg_id" {
  description = "EKS Security Group ID"
  type = string
}

variable "eks_nodes_sg_id" {
    description = "EKS Nodes Security Group ID"
    type = string
}

variable "alb_public_sg_id" {
  description = "ALB public Security Group ID"
  type = string
}

variable "alb_private_sg_id" {
  description = "ALB private Security Group ID"
  type = string
}

# variable "acm_public_cert_arn" {
#   description = "ARN of the public ACM certificate"
#   type        = string
# }

variable "nodegroup_config" {
  description = "Node group configurations"
  type        = list(object({
    name         = string
    ami_type     = string
    capacity_type = string
    instance_type = string
    min_size      = number
    max_size      = number
    desired_size  = number
    labels        = map(string)
    tags          = map(string)
  }))
  default = [
    {
      name          = "shopsmart1"
      ami_type      = "AL2_x86_64" ##CUSTOM
      capacity_type = "ON_DEMAND"
      instance_type = "t3a.medium" ##t2.micro
      desired_size  = 1
      min_size      = 1
      max_size      = 2
      labels        = {
        "ng_id" = "ss1",
        "shopsmart1" = "true",
        "services" = "true"
      }
      tags = {
        "environment" = "dev",
        "set" = "shopsmart-1",
        createdAt = "15/10/2025"
      }
    },
    {
      name          = "shopsmart2"
      ami_type      = "AL2_x86_64" ##CUSTOM
      capacity_type = "ON_DEMAND"
      instance_type = "t3a.medium"
      desired_size  = 1
      min_size      = 1
      max_size      = 2
      labels        = {
        "ng_id" = "ss2",
        "shopsmart2" = "true",
        "services" = "true"
      }
      tags = {
        "environment" = "dev",
        "set" = "shopsmart-2",
        createdAt = "15/10/2025"
      }
    },
    {
      name          = "ss-elk"
      ami_type      = "AL2_x86_64" ##CUSTOM
      capacity_type = "ON_DEMAND"
      instance_type = "t3a.medium"
      desired_size  = 1
      min_size      = 1
      max_size      = 2
      labels        = {
        "ng_id" = "ss-elk",
        "ss-elk" = "true"
      }
      tags = {
        "environment" = "dev",
        "set" = "ss-elk",
        createdAt = "22/10/2025"
      }
    },
    {
      name          = "ss-traefik"
      ami_type      = "AL2_x86_64" ##CUSTOM
      capacity_type = "ON_DEMAND"
      instance_type = "t3a.medium"
      desired_size  = 1
      min_size      = 1
      max_size      = 2
      labels        = {
        "ng_id" = "ss-traefik",
        "ss-traefik" = "true"
      }
      tags = {
        "environment" = "dev",
        "set" = "ss-traefik",
        createdAt = "20/10/2025"
      }
    }
  ]
}

variable "ingress_rules" {
  type = map(object({
    host = string
    service_name = string
    service_port = number
  }))
  default = {
    profile_service = {
      host = "profile-service.ss.aws.local"
      service_name = "profile-service"
      service_port = 80
    }
    product_service = {
      host = "product-service.ss.aws.local"
      service_name = "product-service"
      service_port = 80
    }
    order_service = {
      host = "order-service.ss.aws.local"
      service_name = "order-service"
      service_port = 80
    }
  }
}


variable "dns_records" {
  type = map(string)
  default = {
    "profile-service.ss.aws.local" = "profile-service"
    "product-service.ss.aws.local" = "product-service"
    "order-service.ss.aws.local"   = "order-service"
  }
}