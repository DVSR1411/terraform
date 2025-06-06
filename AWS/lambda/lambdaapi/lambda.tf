data "aws_region" "current" {}
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/demo.py"
  output_path = "${path.module}/demo.zip"
}
resource "aws_lambda_function" "test_lambda" {
  function_name    = "test"
  role            = aws_iam_role.lambda_role.arn
  handler         = "demo.lambda_handler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime         = "python3.9"
  timeout         = 5
  depends_on = [aws_dynamodb_table.mydb, aws_iam_role.lambda_role]
}