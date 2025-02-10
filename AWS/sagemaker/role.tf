resource "aws_iam_role" "myrole" {
  name = "sagemaker-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.myrole.name
  policy_arn = aws_iam_policy.mypolicy.arn
}
resource "aws_iam_role_policy_attachment" "fullaccess" {
  role       = aws_iam_role.myrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}
resource "aws_iam_role_policy_attachment" "canvasfull" {
    role       = aws_iam_role.myrole.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasFullAccess" 
}
resource "aws_iam_role_policy_attachment" "canvasdata" {
    role       = aws_iam_role.myrole.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasDataPrepFullAccess" 
}
resource "aws_iam_role_policy_attachment" "canvasai" {
    role       = aws_iam_role.myrole.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerCanvasAIServicesAccess" 
}
resource "aws_iam_policy" "mypolicy" {
  name = "sagemaker-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject", 
                "s3:DeleteObject",
                "s3:ListBucket"
            ]
            Resource = [
                "arn:aws:s3:::*"
            ]
        }
    ]
    })
}