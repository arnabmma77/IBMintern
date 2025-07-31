# IAM Role for AWS Config
resource "aws_iam_role" "aws_config_role" {
  name = "aws-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "config.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Inline IAM Policy for AWS Config
resource "aws_iam_role_policy" "config_policy_inline" {
  name = "aws-config-policy"
  role = aws_iam_role.aws_config_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:PutObject", "s3:GetBucketAcl"],
        Resource = [
          "arn:aws:s3:::multi-tenant-cloudtrail-logs/AWSLogs/*",
          "arn:aws:s3:::multi-tenant-cloudtrail-logs"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "config:Put*",
          "config:Get*",
          "config:Describe*",
          "config:Deliver*"
        ],
        Resource = "*"
      }
    ]
  })
}

# AWS Config Recorder
resource "aws_config_configuration_recorder" "config" {
  name     = "multi-tenant-config"
  role_arn = aws_iam_role.aws_config_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

# AWS Config Delivery Channel
resource "aws_config_delivery_channel" "config_channel" {
  name           = "multi-tenant-config-channel"
  s3_bucket_name = aws_s3_bucket.cloudtrail_logs.bucket
}

# Start the Config Recorder
resource "aws_config_configuration_recorder_status" "config_status" {
  name       = aws_config_configuration_recorder.config.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.config_channel]
}

# Rule 1: Ensure S3 Bucket Encryption
resource "aws_config_config_rule" "s3_encryption_rule" {
  name = "s3-bucket-server-side-encryption-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder_status.config_status]
}

# Rule 2: Block Public Read Access to S3
resource "aws_config_config_rule" "s3_public_access_blocked" {
  name = "s3-bucket-public-read-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  depends_on = [aws_config_configuration_recorder_status.config_status]
}
