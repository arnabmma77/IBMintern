# Secure Multi-Tenant Cloud File Upload using AWS (Terraform + CLI)

This project demonstrates secure multi-tenant architecture on AWS, ensuring strict tenant isolation using IAM policies and S3 bucket-level permissions.

## ✅ Services Used

- **IAM** – User and role management for TenantA and TenantB.
- **S3** – Secure bucket storage per tenant.
- **Lambda** – (Initially) for generating presigned upload URLs.
- **API Gateway** – (Initially) for frontend-triggered Lambda execution.
- **KMS** – Encrypt each tenant's S3 bucket data.
- **CloudTrail + AWS Config** – Enable logging and auditing.
- **Terraform** – Complete infrastructure as code.
- **AWS CLI** – Final secure CLI-based upload and demo after frontend issues.

---

## 🔧 Project Setup Summary

### Week 1: Tenant Structure & IAM
- Created IAM users for:
  - `TenantA-User1`, `TenantA-User2`, `TenantA-User3`
  - `TenantB-User1`, `TenantB-User2`, `TenantB-User3`
- Created IAM roles for each tenant group.
  <img width="1899" height="766" alt="Screenshot (307)" src="https://github.com/user-attachments/assets/3d464df9-e3b8-45ec-9987-50404b74d81d" />


### Week 2: S3 Buckets & Isolation
- Created unique buckets per user, e.g.:
  - `tenanta-user1-storage`, `tenantb-user1-storage`, etc.
- Applied S3 bucket policies to block public access and enable private user access only.
  <img width="1920" height="1080" alt="Screenshot (308)" src="https://github.com/user-attachments/assets/6441bcf5-5958-401d-86d3-6852c36de67b" />


### Week 3: Encryption & TLS
- Created **KMS keys** for each tenant's data.
- Configured **server-side encryption** for each S3 bucket.
  <img width="1920" height="1080" alt="Screenshot (309)" src="https://github.com/user-attachments/assets/8c4035a8-c06b-4840-880c-f9dc6224098e" />


### Week 4: Logging & Audit Trails
- Enabled **AWS CloudTrail** to capture API activity.
- Configured **AWS Config rules**:
  - Prevent public buckets.
  - Enforce S3 encryption.
    <img width="1920" height="1080" alt="Screenshot (310)" src="https://github.com/user-attachments/assets/2f27d0b1-374a-4bb1-b92a-296ee732d689" />


---

## ✅ CLI-Based Final Workflow

Due to CORS issues in frontend-browser approach, we finalized the **AWS CLI** demo.

### Steps:
1. Upload file to own bucket:
```bash
aws s3 cp "file.txt" s3://tenanta-user1-storage/ --profile tenanta-user1
```
2. Attempt cross-tenant upload (denied):
```bash
aws s3 cp "file.txt" s3://tenantb-user1-storage/ --profile tenanta-user1
# Result: AccessDenied
```

### IAM Policy Structure:
- Inline policies restricted access **only** to the corresponding user bucket.
- Cross-tenant actions explicitly denied.

---

## ✅ Final Verification

- ✅ Own bucket upload: **Allowed**
- ❌ Cross-tenant upload: **Denied**
- 🎯 Isolation achieved through IAM + S3 + Terraform.
<img width="1920" height="1080" alt="Screenshot (304)" src="https://github.com/user-attachments/assets/d8f0c0a0-f5a7-4f66-9417-abdecf6d8bd1" />

---

## 🧹 Cleanup Steps (Terraform)

1. Run:
```bash
terraform destroy


```
2. If errors:
   - Manually delete:
     - S3 access points
     - IAM login profiles
     - Attached user policies
     - IAM access keys
       
<img width="1920" height="1080" alt="Screenshot (315)" src="https://github.com/user-attachments/assets/7142fc1d-ccb0-4806-a637-0bd0ab3358d7" />


---

## 📂 Folder Structure

```
├── iam.tf
├── s3.tf
├── kms.tf
├── lambda.tf
├── api_gateway.tf
├── config_trail.tf
├── outputs.tf
├── variables.tf
├── README.md   ← this file
```

---

## 💡 Author
Project by: **Arnab Mukherjee**  
Guided by: IBM Cloud Internship 2025
