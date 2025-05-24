resource "aws_secretsmanager_secret" "task3_docdb_secret" {
  name = "task3-docdb"
}

resource "aws_secretsmanager_secret_version" "task3_docdb_secret_version" {
  secret_id     = aws_secretsmanager_secret.task3_docdb_secret.id
  secret_string = jsonencode({
    username = var.docdb_master_username
    password = var.docdb_master_password
    endpoint = var.task3_docdb_cluster_endpoint
  })
}
