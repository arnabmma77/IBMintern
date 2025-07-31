output "tenant_a_role_arn" {
  value = aws_iam_role.tenant_a_role.arn
}

output "tenant_b_role_arn" {
  value = aws_iam_role.tenant_b_role.arn
}
