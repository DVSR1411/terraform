resource "aws_iam_policy" "mypolicy" {
    name = "Demo"
    policy = file("policy.json")
}
#Attach policy to user
resource "aws_iam_user_policy_attachment" "access" {
    user       = aws_iam_user.myuser.name
    policy_arn = aws_iam_policy.mypolicy.arn
}