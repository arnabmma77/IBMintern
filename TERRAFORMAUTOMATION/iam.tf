#######################
# EXISTING IAM SETUP
#######################

resource "aws_iam_role" "tenant_a_role" {
  name = "TenantA-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "tenant_b_role" {
  name = "TenantB-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

###########################
# NEW: Lambda IAM Role
###########################

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_s3_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_s3_kms" {
  name = "lambda_s3_kms_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:PutObject"],
        Resource = "arn:aws:s3:::tenanta-user1-storage/*"
      },
      {
        Effect = "Allow",
        Action = ["kms:GenerateDataKey", "kms:Encrypt"],
        Resource = "arn:aws:kms:us-east-1:851725174812:key/8563cb93-22f7-4860-9e51-0bd2909848ec"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_s3_kms.arn
}
