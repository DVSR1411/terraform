resource "aws_s3_bucket_policy" "mypolicy" {
    bucket = aws_s3_bucket.mybucket.bucket
    policy = <<EOF
    {
        "Id": "Policy1728029345228",
        "Version": "2012-10-17",
        "Statement": [
        {
            "Sid": "Stmt1728029336110",
            "Action": [
            "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": "${aws_s3_bucket.mybucket.arn}/*",
            "Principal": {
            "AWS": [
                "Hulk"
            ]
            }
        }
        ]
    }
    EOF
    # Principal can be specified dynamically as aws_iam_user.myuser.name
}