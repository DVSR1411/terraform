data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
resource "aws_bedrock_model" "my_model" {
  name           = "DeepSeek-R1-Distill-Llama-8B"
  model_location = "s3://${aws_s3_bucket.bucket.id}/models/"
  model_type    = "llama"
  role_arn       = aws_iam_role.bedrock_role.arn
  region         = data.aws_region.current.name
  tags = {
    name        = "DeepSeek-R1-Distill-Llama-8B"
    description = "My model"
  }
  depends_on = [aws_iam_role.bedrock_role]
}
resource "aws_iam_role" "bedrock_role" {
  name = "bedrock-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "bedrock.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:model-import-job/*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "bedrock_policy" {
  name = "bedrock-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeVpcs",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface"
        ],
        Resource = [
          "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
          "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface"
        ],
        Resource = [
          "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*"
        ],
        Condition = {
          StringEquals = {
            "aws:RequestTag/BedrockManaged" = "true"
          },
          ArnLike = {
            "aws:RequestTag/BedrockModelImportJobArn" = "arn:aws:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:model-import-job/*"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DeleteNetworkInterface",
          "ec2:DeleteNetworkInterfacePermission"
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:ResourceTag/BedrockManaged" = "true"
          },
          ArnLike = {
            "aws:ResourceTag/BedrockModelImportJobArn" = "arn:aws:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:model-import-job/*",
            "ec2:Subnet"                               = "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*"
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateTags"
        ],
        Resource = [
          "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*"
        ],
        Condition = {
          StringEquals = {
            "ec2:CreateAction" = "CreateNetworkInterface"
          },
          ForAllValues = {
            StringEquals = {
              "aws:TagKeys" = [
                "BedrockManaged",
                "BedrockModelImportJobArn"
              ]
            }
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bedrock_role_policy_attachment" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}