resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node-sg"
  description = "Security group for EKS nodes"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow access to EKS API"
  }

  # Allow DNS (UDP)
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow DNS resolution (UDP)"
  }

  # Allow DNS (TCP)
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow DNS resolution (TCP)"
  }

  # Allow intra-node communication (Node-to-Node communication)
  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow node-to-node communication"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}

resource "aws_security_group" "public_alb_sg" {
  name        = "public-alb-sg"
  description = "Security group for Public ALB"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress - Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-alb-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "private_alb_sg" {
  name        = "private-alb-sg"
  description = "Security group for Private ALB"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic from within the VPC (replace with your VPC CIDR block)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # VPC CIDR block or specific trusted CIDR blocks
    # make the above later aws_vpc.main.cidr_block
  }

  # Allow HTTPS traffic from within the VPC (replace with your VPC CIDR block)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # VPC CIDR block or specific trusted CIDR blocks
    # make the above later aws_vpc.main.cidr_block
  }

  # Egress - Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-alb-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}