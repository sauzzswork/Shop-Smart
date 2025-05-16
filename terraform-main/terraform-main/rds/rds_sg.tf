resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow access to RDS from EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # security_groups = [module.vpc.eks_node_sg_id]  # Allow traffic from EKS nodes
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP address, using it temporarily, later to be removed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "postgres-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "PostgresSubnetGroup"
  }
}