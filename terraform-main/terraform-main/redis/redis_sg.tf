resource "aws_security_group" "redis_sg" {
  name        = "redis_sg"
  description = "Allow Redis traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow Redis traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "redis-subnet-group"
  subnet_ids = var.private_subnet_ids
}