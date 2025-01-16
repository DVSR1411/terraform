resource "random_string" "bucket_suffix" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "sath-${random_string.bucket_suffix.id}"
  force_destroy = true
}
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}