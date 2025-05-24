output "docdb_master_username" {
  value = var.docdb_master_username
}

output "docdb_master_password" {
  value = var.docdb_master_password
}

output "task3_docdb_cluster_endpoint" {
  value = aws_docdb_cluster.task3_docdb_cluster.endpoint
}
