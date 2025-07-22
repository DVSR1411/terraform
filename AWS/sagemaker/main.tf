resource "aws_sagemaker_notebook_instance" "myni" {
  name          = "demo"
  role_arn      = aws_iam_role.myrole.arn
  instance_type = "ml.t2.medium"
  volume_size   = 20
  subnet_id     = local.random_subnet_id
  security_groups = [aws_security_group.mysg.id]
  tags = {
    Name = "demo"
  }
}
output "endpoint" {
  value = "https://${aws_sagemaker_notebook_instance.myni.url}/lab"
}
