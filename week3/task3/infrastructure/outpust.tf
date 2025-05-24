output "ec2_instance_public_ip" {
  value = module.ec2.instance_public_ip
}
output "task3_docdb_secret_arn" {
  value = module.secret_manager.task3_docdb_secret_arn
}