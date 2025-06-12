resource "aws_iam_role" "ec2_role" {
  name = "EC2Jenkinsrole"
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
resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2-accesspolicy"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "sts:AssumeRole"
      ]
        Resource = aws_iam_role.ec2_role.arn
      }
    ]
  })
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2eksprofile"
  role = aws_iam_role.ec2_role.name
}
