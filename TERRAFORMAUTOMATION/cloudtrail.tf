# S3 Bucket for CloudTrail and AWS Config logs
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "multi-tenant-cloudtrail-logs"
  force_destroy = true

  tags = {
    Name = "CloudTrailLogs"
  }
}

# Bucket Policy for CloudTrail + AWS Config logging
resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "AWSCloudTrailWrite",
        Effect: "Allow",
        Principal: {
          Service: "cloudtrail.amazonaws.com"
        },
        Action: "s3:GetBucketAcl",
        Resource: "arn:aws:s3:::multi-tenant-cloudtrail-logs"
      },
      {
        Sid: "AWSCloudTrailWriteLogs",
        Effect: "Allow",
        Principal: {
          Service: "cloudtrail.amazonaws.com"
        },
        Action: "s3:PutObject",
        Resource: "arn:aws:s3:::multi-tenant-cloudtrail-logs/AWSLogs/*",
        Condition: {
          StringEquals: {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      },
      {
        Sid: "AWSConfigWrite",
        Effect: "Allow",
        Principal: {
          Service: "config.amazonaws.com"
        },
        Action: "s3:PutObject",
        Resource: "arn:aws:s3:::multi-tenant-cloudtrail-logs/AWSLogs/*",
        Condition: {
          StringEquals: {
            "s3:x-amz-acl": "bucket-owner-full-control"
          }
        }
      },
      {
        Sid: "AWSConfigGetACL",
        Effect: "Allow",
        Principal: {
          Service: "config.amazonaws.com"
        },
        Action: "s3:GetBucketAcl",
        Resource: "arn:aws:s3:::multi-tenant-cloudtrail-logs"
      }
    ]
  })
}

# CloudTrail logging setup
resource "aws_cloudtrail" "multi_tenant_trail" {
  name                          = "multi-tenant-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  depends_on = [aws_s3_bucket_policy.cloudtrail_policy]

  tags = {
    Name = "MultiTenantCloudTrail"
  }
}
