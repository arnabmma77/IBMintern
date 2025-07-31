# S3 Buckets for TenantA Users
resource "aws_s3_bucket" "tenanta_user1" {
  bucket = "tenanta-user1-storage"
  tags = {
    Tenant = "TenantA"
    User   = "User1"
  }
}

resource "aws_s3_bucket" "tenanta_user2" {
  bucket = "tenanta-user2-storage"
  tags = {
    Tenant = "TenantA"
    User   = "User2"
  }
}

resource "aws_s3_bucket" "tenanta_user3" {
  bucket = "tenanta-user3-storage"
  tags = {
    Tenant = "TenantA"
    User   = "User3"
  }
}

# S3 Buckets for TenantB Users
resource "aws_s3_bucket" "tenantb_user1" {
  bucket = "tenantb-user1-storage"
  tags = {
    Tenant = "TenantB"
    User   = "User1"
  }
}

resource "aws_s3_bucket" "tenantb_user2" {
  bucket = "tenantb-user2-storage"
  tags = {
    Tenant = "TenantB"
    User   = "User2"
  }
}

resource "aws_s3_bucket" "tenantb_user3" {
  bucket = "tenantb-user3-storage"
  tags = {
    Tenant = "TenantB"
    User   = "User3"
  }
}
