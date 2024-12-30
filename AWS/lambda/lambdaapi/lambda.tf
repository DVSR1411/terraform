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
  runtime         = "python3.13"
  timeout         = 5
  environment {
    variables = {
      my_bucket = aws_s3_bucket.my_bucket.id
    }
  }
}