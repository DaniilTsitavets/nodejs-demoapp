output "vpc_id" {
  value = aws_vpc.task3_vpc.id
}

output "public_subnets" {
  value = [for s in aws_subnet.task3_public_subnet : s.id]
}

output "private_subnets" {
  value = [for s in aws_subnet.task3_private_subnet : s.id]
}