resource "aws_iam_role" "ec2_role" {
  name = "task3_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ec2_secrets_policy" {
  name = "task3_ec2_secrets_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = var.task3_docdb_secret_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_secrets_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "task3_ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}
