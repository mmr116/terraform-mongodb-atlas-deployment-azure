variable "subscription_id" {
  description = "Azure subscription ID"
}

variable "client_id" {
  description = "Azure client ID"
}

variable "client_secret" {
  description = "Azure client secret"
}

variable "tenant_id" {
  description = "Azure tenant ID"
}

variable "key_vault_id" {
  description = "Azure Key Vault ID"
  type        = string
}

variable "project_name" {
  description = "Name of the MongoDB Atlas project"
  type        = string
}

variable "provider_name" {
  description = "Name of the cloud provider"
  type        = string
}

variable "cluster_type" {
  description = "Type of the MongoDB Atlas cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the MongoDB Atlas cluster"
  type        = string
}

variable "cloud_primary_region" {
  description = "Name of the primary region"
  type        = string
}

variable "cloud_primary_region_priority" {
  description = "Priority of the primary region"
  type        = string
}

variable "cloud_primary_region_elect_node" {
  description = "Number of electable nodes in the primary region"
  type        = string
}

variable "cloud_secondary_region" {
  description = "Name of the secondary region"
  type        = string
}

variable "cloud_secondary_region_priority" {
  description = "Priority of the secondary region"
  type        = string
}

variable "cloud_secondary_region_elect_node" {
  description = "Number of electable nodes in the secondary region"
  type        = string
}

variable "cloud_third_region" {
  description = "Name of the third region"
  type        = string
}

variable "cloud_third_region_priority" {
  description = "Priority of the third region"
  type        = string
}

variable "cloud_third_region_elect_node" {
  description = "Number of electable nodes in the third region"
  type        = string
}

variable "instance_size_name" {
  description = "Name of the instance size"
  type        = string
}

variable "auto_scaling_enabled" {
  description = "Status of auto_scaling"
  type        = bool
}

variable "min_instance_size" {
  description = "Min instance size"
  type        = string
}

variable "max_instance_size" {
  description = "Max instance size"
  type        = string
}

variable "auto_scale_down_enabled" {
  description = "Status of auto_scaling"
  type        = bool 
}

variable "mongo_db_major_version" {
  description = "MongoDB Atlas major version"
  type        = string
}

variable "cloud_backup" {
  description = "Cloud daily backup"
  type        = bool
}

variable "pitr_backup_enabled" {
  description = "Cloud point-in-time-recovery backup"
  type        = bool
}

variable "admin_username" {
  description = "Username for the MongoDB Atlas admin user"
  type        = string
}

variable "app_username" {
  description = "Username for the MongoDB Atlas app user"
  type        = string
}

variable "tags" {
  description = "List of maps containing tag key-value pairs"
  type        = list(object({
    tag_key   = string
    tag_value = string
  }))
}
