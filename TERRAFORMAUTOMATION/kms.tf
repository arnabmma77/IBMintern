# 🔐 KMS Key for TenantA
resource "aws_kms_key" "tenant_a_kms" {
  description             = "KMS key for TenantA"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags = {
    Name   = "TenantA-KMS"
    Tenant = "TenantA"
  }
}

resource "aws_kms_alias" "tenant_a_alias" {
  name          = "alias/tenantA-key"
  target_key_id = aws_kms_key.tenant_a_kms.id
}

# 🔐 KMS Key for TenantB
resource "aws_kms_key" "tenant_b_kms" {
  description             = "KMS key for TenantB"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags = {
    Name   = "TenantB-KMS"
    Tenant = "TenantB"
  }
}

resource "aws_kms_alias" "tenant_b_alias" {
  name          = "alias/tenantB-key"
  target_key_id = aws_kms_key.tenant_b_kms.id
}
