# IAM Users for TenantA
resource "aws_iam_user" "tenanta_user1" {
  name = "TenantA-User1"
  tags = {
    Tenant = "TenantA"
  }
}

resource "aws_iam_user" "tenanta_user2" {
  name = "TenantA-User2"
  tags = {
    Tenant = "TenantA"
  }
}

resource "aws_iam_user" "tenanta_user3" {
  name = "TenantA-User3"
  tags = {
    Tenant = "TenantA"
  }
}

# IAM Users for TenantB
resource "aws_iam_user" "tenantb_user1" {
  name = "TenantB-User1"
  tags = {
    Tenant = "TenantB"
  }
}

resource "aws_iam_user" "tenantb_user2" {
  name = "TenantB-User2"
  tags = {
    Tenant = "TenantB"
  }
}

resource "aws_iam_user" "tenantb_user3" {
  name = "TenantB-User3"
  tags = {
    Tenant = "TenantB"
  }
}
