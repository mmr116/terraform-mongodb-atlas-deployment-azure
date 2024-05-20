terraform {
  # Define required MongoDB provider and versions
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.13.0"
    }
  }
}
# Define the Azure provider block and authentication configuration using service principal
provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Retrieve MongoDB Atlas API secrets from Azure Key Vault
data "azurerm_key_vault_secret" "mongodb_atlas_api_private_key" {
  name         = "mongodb-atlas-api-private-key"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "mongodb_atlas_api_public_key" {
  name         = "mongodb-atlas-api-public-key"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "mongodb_atlas_organization_id" {
  name         = "mongodb-atlas-organization-id"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "mongodb_atlas_admin_user" {
  name         = "mongodb-atlas-admin-user-password"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "mongodb_atlas_app_user" {
  name         = "mongodb-atlas-app-user-password"
  key_vault_id = var.key_vault_id
}

# Define the MongoDB Atlas provider block
provider "mongodbatlas" {
  public_key  = data.azurerm_key_vault_secret.mongodb_atlas_api_public_key.value
  private_key = data.azurerm_key_vault_secret.mongodb_atlas_api_private_key.value
}

# Define the MongoDB Atlas project resource
resource "mongodbatlas_project" "example" {
  name        = var.project_name
  org_id      = data.azurerm_key_vault_secret.mongodb_atlas_organization_id.value
}

# Define database users
resource "mongodbatlas_database_user" "admin_user" {
  username           = var.admin_username
  password           = data.azurerm_key_vault_secret.mongodb_atlas_admin_user.value
  project_id         = mongodbatlas_project.example.id
  auth_database_name = "admin"
  roles {
    role_name    = "atlasAdmin"
    database_name = "admin"
  }
}

resource "mongodbatlas_database_user" "app_user" {
  username           = var.app_username
  password           = data.azurerm_key_vault_secret.mongodb_atlas_app_user.value
  project_id         = mongodbatlas_project.example.id
  auth_database_name = "admin"
  roles {
    role_name    = "readWriteAnyDatabase"
    database_name = "admin"
  }
}

# Define MongoDB Atlas maintenance window
resource "mongodbatlas_maintenance_window" "example" {
  project_id             = mongodbatlas_project.example.id
  day_of_week            = 7
  hour_of_day            = 6
  auto_defer_once_enabled = true
}

# Define the MongoDB Atlas cluster resource
resource "mongodbatlas_cluster" "example" {
  project_id                  = mongodbatlas_project.example.id
  name                        = var.cluster_name
  cluster_type                = var.cluster_type
  mongo_db_major_version      = var.mongo_db_major_version
  provider_name               = var.provider_name
  provider_instance_size_name = var.instance_size_name

  # Specify auto-scaling configuration
  auto_scaling_compute_enabled                    = var.auto_scaling_enabled
  auto_scaling_compute_scale_down_enabled         = var.auto_scale_down_enabled
  provider_auto_scaling_compute_max_instance_size = var.max_instance_size
  provider_auto_scaling_compute_min_instance_size = var.min_instance_size

  # Specify cloud backup and continous cloud backup configuration
  cloud_backup = var.cloud_backup
  pit_enabled  = var.pitr_backup_enabled

  # specify cluster status
  paused                         = var.cluster_paused
  termination_protection_enabled = var.termination_protection_enabled

  # Specify replication configuration in a multi-region cluster
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.cloud_primary_region
      electable_nodes = var.cloud_primary_region_elect_node
      priority        = var.cloud_primary_region_priority
      read_only_nodes = 0
    }
    regions_config {
      region_name     = var.cloud_secondary_region
      electable_nodes = var.cloud_secondary_region_elect_node
      priority        = var.cloud_secondary_region_priority
      read_only_nodes = 0
    }
    regions_config {
      region_name     = var.cloud_third_region
      electable_nodes = var.cloud_third_region_elect_node
      priority        = var.cloud_third_region_priority
      read_only_nodes = 0
    }
  }

  # Specify tags for the cluster
  dynamic "tags" {
    for_each = { for idx, tag in var.tags : idx => tag }
    content {
      key   = tags.value.tag_key
      value = tags.value.tag_value
    }
  }
}

# Output section
output "mongodbatlas_project_id" {
  value = mongodbatlas_project.example.id
}

output "mongodbatlas_cluster_id" {
  value = mongodbatlas_cluster.example.id
}

output "mongodbatlas_cluster_name" {
  value = mongodbatlas_cluster.example.name
}

output "admin_user_username" {
  value = mongodbatlas_database_user.admin_user.username
}

output "app_user_username" {
  value = mongodbatlas_database_user.app_user.username
}
