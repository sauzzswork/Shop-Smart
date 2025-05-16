resource "aws_security_group" "documentdb_sg" {
  name        = "documentdb-sg"
  description = "Security group for documentdb"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow inbound traffic from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "documentdb-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DocumentDBSubnetGroup"
  }
}