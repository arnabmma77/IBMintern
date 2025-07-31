locals {
  bucket_names = [
    "tenanta-user1-storage",
    "tenanta-user2-storage",
    "tenanta-user3-storage",
    "tenantb-user1-storage",
    "tenantb-user2-storage",
    "tenantb-user3-storage"
  ]
}

resource "aws_s3_bucket_cors_configuration" "all_cors" {
  for_each = toset(local.bucket_names)

  bucket = each.value

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
