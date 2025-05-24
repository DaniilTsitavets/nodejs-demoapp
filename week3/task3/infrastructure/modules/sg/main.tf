resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "-1"
    from_port = 0
    to_port   = 0
  }
}

resource "aws_security_group" "docdb_sg" {
  vpc_id = var.vpc_id
  ingress {
    security_groups = [aws_security_group.ec2_sg.id]
    protocol  = "tcp"
    from_port = 27017
    to_port   = 27017
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "-1"
    from_port = 0
    to_port   = 0
  }

  tags = {
    Name = "task3_docdb_sg"
  }
}