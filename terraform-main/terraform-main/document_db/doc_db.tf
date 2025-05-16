resource "aws_docdb_cluster" "documentdb" {
  cluster_identifier           = "documentdb"
  engine_version               = "3.6.0"
  vpc_security_group_ids       = [aws_security_group.documentdb_sg.id]
  skip_final_snapshot          = true
  preferred_maintenance_window = "sun:01:30-sun:02:30"

  db_subnet_group_name      = aws_db_subnet_group.default.name
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]

  master_username = "admin"
  master_password = "abcd1234"

  tags = {
    Environment = "Dev"
    Project     = "DocumentDB Cluster"
  }
}

resource "aws_docdb_cluster_instance" "documentdb_instance" {
  count              = 2
  cluster_identifier = aws_docdb_cluster.documentdb.cluster_identifier
  instance_class     = "db.r5.large"
}


