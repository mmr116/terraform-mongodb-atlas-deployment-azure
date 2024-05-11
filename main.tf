terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.13.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

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

provider "mongodbatlas" {
  public_key  = data.azurerm_key_vault_secret.mongodb_atlas_api_public_key.value
  private_key = data.azurerm_key_vault_secret.mongodb_atlas_api_private_key.value
}

resource "mongodbatlas_project" "example" {
  name        = var.project_name
  org_id      = data.azurerm_key_vault_secret.mongodb_atlas_organization_id.value
}

resource "mongodbatlas_cluster" "example" {
  project_id                  = mongodbatlas_project.example.id
  name                        = var.cluster_name
  cluster_type                = var.cluster_type
  mongo_db_major_version      = var.mongo_db_major_version
  provider_name               = var.provider_name
  provider_instance_size_name = var.instance_size_name
  
  auto_scaling_compute_enabled                    = var.auto_scaling_enabled
  auto_scaling_compute_scale_down_enabled         = var.auto_scale_down_enabled
  provider_auto_scaling_compute_max_instance_size = var.max_instance_size
  provider_auto_scaling_compute_min_instance_size = var.min_instance_size
  
  cloud_backup = var.cloud_backup
  pit_enabled  = var.pitr_backup_enabled
  
 
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
  
  tags {
    key   = var.tag_env
    value = var.tag_env_value
  }  
}