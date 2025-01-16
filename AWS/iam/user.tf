resource "aws_iam_user" "myuser" {
    name = "Hulk"
    tags = {
        Description = "Hulk smash"
    }
}