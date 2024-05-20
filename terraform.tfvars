subscription_id = "your-subscription-id"
client_id       = "your-client-id"
client_secret   = "your-client-secret"
tenant_id       = "your-tenant-id"
key_vault_id    = "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<key-vault-name>"
project_name                       = "project-101"
provider_name                      = "AZURE"
cluster_type                       = "REPLICASET"
cluster_name                       = "cluster-101"
cloud_primary_region               = "US_CENTRAL"
cloud_primary_region_priority      = "7"
cloud_primary_region_elect_node    = "1"
cloud_secondary_region             = "US_EAST"
cloud_secondary_region_priority    = "6"
cloud_secondary_region_elect_node  = "1"
cloud_third_region                 = "US_NORTH_CENTRAL"
cloud_third_region_priority        = "5"
cloud_third_region_elect_node      = "1"
instance_size_name                 = "M10"
auto_scaling_enabled               = true 
min_instance_size                  = "M10"
max_instance_size                  = "M20"
auto_scale_down_enabled            = true 
mongo_db_major_version             = "7.0"
cloud_backup                       = true
pitr_backup_enabled                = true
cluster_paused                     = false
termination_protection_enabled     = true
admin_username                     = "admin_user"
app_username                       = "app_user"
tags = [
  {
    tag_key   = "env"
    tag_value = "dev"
  },
  {
    tag_key   = "cloud_provider"
    tag_value = "azure"
  },
  {
    tag_key   = "costcenter"
    tag_value = "abcd"
  }
]
