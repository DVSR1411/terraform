resource "random_string" "my-s3-bucket" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}
resource "null_resource" "run_py_script" {
  provisioner "local-exec" {
    command = "pip install -r requirements.txt && python deepfake.py"
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket        = "deepseek-${random_string.my-s3-bucket.id}"
  force_destroy = true
  tags = {
    Name        = "Deepseek"
    Description = "This is a bucket to store my model"
  }
  depends_on = [null_resource.run_py_script]
}
resource "aws_s3_object" "myobject" {
  for_each = fileset("./models", "**")
  bucket   = aws_s3_bucket.mybucket.bucket
  key      = each.value
  source   = "${path.module}/models/${each.value}"
  etag     = filemd5("${path.module}/models/${each.value}")
}