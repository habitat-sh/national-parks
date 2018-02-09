variable "azure_region" {
  default = "eastus"
}

variable "azure_public_key_path" {
  default = "/path/to/ssh/key"
}

variable "azure_private_key_path" {
  default = "/path/to/ssh/key"
}

variable "azure_image_user" {
  default = "azureuser"
}

variable "azure_image_password" {
  default = "Azur3pa$$word"
}

variable "azure_sub_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "azure_tenant_id" {
  default = "xxxxxxx-xxxx-xxxx-xxxxxxxxxx"
}

variable "application" {
  default = "nationalparks"
}

variable "habitat_origin" {
  default = "scottford"
}

variable "bldr_url" {
  default = "https://bldr.habitat.sh"
}

variable "release_channel" {
  default = "stable"
}

variable "group" {
  default = "dev"
}

variable "update_strategy" {
  default = "at-once"
}
