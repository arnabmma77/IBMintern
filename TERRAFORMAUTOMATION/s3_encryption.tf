# TenantA User1 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenanta_user1_enc" {
  bucket = aws_s3_bucket.tenanta_user1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_a_kms.arn
    }
  }
}

# TenantA User2 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenanta_user2_enc" {
  bucket = aws_s3_bucket.tenanta_user2.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_a_kms.arn
    }
  }
}

# TenantA User3 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenanta_user3_enc" {
  bucket = aws_s3_bucket.tenanta_user3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_a_kms.arn
    }
  }
}

# TenantB User1 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenantb_user1_enc" {
  bucket = aws_s3_bucket.tenantb_user1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_b_kms.arn
    }
  }
}

# TenantB User2 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenantb_user2_enc" {
  bucket = aws_s3_bucket.tenantb_user2.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_b_kms.arn
    }
  }
}

# TenantB User3 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "tenantb_user3_enc" {
  bucket = aws_s3_bucket.tenantb_user3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.tenant_b_kms.arn
    }
  }
}
