# Azure Region
variable "azure_region" {
  default = "westus2"
}

# Public SSH key path
variable "azure_public_key_path" {
  default = "/path/to/ssh/key"
}

# Private SSH key path
variable "azure_private_key_path" {
  default = "/path/to/ssh/key"
}

# Azure image user for SSH
variable "azure_image_user" {
  default = "azureuser"
}

# Password for image user
variable "azure_image_password" {
  default = "Azur3pa$$word"
}

# Azure subscriber id
variable "azure_sub_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

# Azure tenant ID
variable "azure_tenant_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

# Application Name
variable "application" {
  default = "nationalparks"
}

# Habitat origin to use
variable "habitat_origin" {
  default = "scottford"
}

# Habitat build url
variable "bldr_url" {
  default = "https://bldr.habitat.sh"
}

# Habitat release channel
variable "release_channel" {
  default = "stable"
}

# Habitat supervior group name
variable "group" {
  default = "dev"
}

# Habitat update strategy 
variable "update_strategy" {
  default = "at-once"
}