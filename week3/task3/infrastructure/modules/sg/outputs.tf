output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "docdb_sg_id" {
  value = aws_security_group.docdb_sg.id
}