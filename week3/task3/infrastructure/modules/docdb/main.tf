resource "aws_docdb_cluster" "task3_docdb_cluster" {
  cluster_identifier   = "task3-docdb-cluster"
  engine               = "docdb"
  master_username      = var.docdb_master_username
  master_password      = var.docdb_master_password
  db_subnet_group_name = aws_docdb_subnet_group.task3_docdb_subnet_group.name
  vpc_security_group_ids = [var.docdb_sg]
  skip_final_snapshot  = true

  tags = {
    Name = "task3_docdb_cluster"
  }
}

resource "aws_docdb_subnet_group" "task3_docdb_subnet_group" {
  name       = "task3-docdb-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "task3_docdb_subnet_group"
  }
}

resource "aws_docdb_cluster_instance" "task3_docdb_instance" {
  count              = var.docdb_instance_count
  identifier         = "task3-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.task3_docdb_cluster.id
  instance_class     = var.docdb_instance_class
  engine             = aws_docdb_cluster.task3_docdb_cluster.engine

  tags = {
    Name = "task3_docdb_instance_${count.index}"
  }
}