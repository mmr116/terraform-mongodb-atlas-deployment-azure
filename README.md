# terraform-mongodb-atlas-deployment-azure

# Overview:

This repository contains Terraform configuration files for deploying resources to MongoDB Atlas on the Azure Cloud. The example provided here deploys a dedicated MongoDB cluster in a multi-region setup with vertical scaling and backup enabled.

# Assumptions:

Terraform version:

Terraform v1.8.2 (installed on CentOS Linux release 8.5.2111)

Secrets Management: Secrets required for deployment, such as MongoDB Atlas Organization ID and MongoDB Atlas API Keys, are stored in Azure Key Vault.

Access Permissions: An Azure Service Principal is utilized to access the secrets stored in Azure Key Vault. It requires the "Key Vault Secrets User" role access on the Azure Key Vault.

Configuration: Before deploying, ensure you have the necessary values associated with the Service Principal and Azure Subscription in the terraform.tfvars file. Here are the required variables:

subscription_id = "your-subscription-id"

client_id       = "your-client-id"

client_secret   = "your-client-secret"

tenant_id       = "your-tenant-id"

key_vault_id    = "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<key-vault-name>"

Replace placeholders such as "your-subscription-id", "your-client-id", "your-client-secret", "your-tenant-id", <subscription-id>, <resource-group-name>, and <key-vault-name> with actual values corresponding to your Azure environment.

# Deployment Steps:
1. Clone Repository: Clone this repository to your local machine.
   
git clone repository-url

3. Initialize Terraform: Navigate to the cloned repository and initialize Terraform.
   
terraform init

5. Review Configuration: Review the configuration files (main.tf, variables.tf, terraform.tfvars) to ensure they match your requirements.
   
terraform plan

7. Execute Deployment: Apply the Terraform configuration to deploy the resources.
   
terraform apply

9. Verify Deployment: After successful deployment, verify that the resources are created as expected.

# Cleanup:
To clean up the deployed resources, you can use Terraform to destroy them.

terraform destroy

# Additional Notes:
Ensure that the Azure Service Principal has appropriate permissions to access the Azure Key Vault secrets.
Keep sensitive information such as client secrets and API keys confidential and secure.
