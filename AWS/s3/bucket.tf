resource "aws_s3_bucket" "mybucket" {
  bucket = "dvsr1411bucket"
  tags = {
    Description = "This is a test bucket"
  }
}