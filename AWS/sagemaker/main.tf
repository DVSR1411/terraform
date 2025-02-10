resource "aws_sagemaker_notebook_instance" "myni" {
  name          = "demo"
  role_arn      = aws_iam_role.myrole.arn
  instance_type = "ml.t2.medium"
  volume_size   = 5
  subnet_id     = local.random_subnet_id
  security_groups = [aws_security_group.mysg.id]
  tags = {
    Name = "demo"
  }
}