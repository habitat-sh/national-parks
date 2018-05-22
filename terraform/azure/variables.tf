variable "azure_region" {}

variable "azure_public_key_path" {}
variable "azure_private_key_path" {}

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

variable "habitat_origin" {}

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

variable "tag_dept" {}

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_application" {
  default = "national-parks"
}

variable "tag_contact" {}

variable "tag_ttl" {
  default = "8"
}
