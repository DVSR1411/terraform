resource "aws_s3_object" "myobject" {
    content = "C:/Users/satwi/Downloads/DevOps/terracodes/AWS/iam/policy.json"
    key = "policy.json"
    bucket = aws_s3_bucket.mybucket.bucket
}