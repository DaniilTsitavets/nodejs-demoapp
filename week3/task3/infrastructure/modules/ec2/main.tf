resource "aws_instance" "task3_ec2_instance" {
  ami                  = var.ec2_ami_id
  user_data            = var.path_to_user_data
  instance_type        = var.ec2_instance_type
  vpc_security_group_ids = [var.ec2_sg_id]
  subnet_id            = var.subnet_id
  iam_instance_profile = var.ec2_instance_profile
  associate_public_ip_address = true

  tags = {
    Name = "task3_ec2_instance"
  }
}