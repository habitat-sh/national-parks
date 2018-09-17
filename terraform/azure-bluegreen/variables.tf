variable "azure_region" { 
  default = "West US"
}

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

variable "habitat_origin" {
  default = "nrycar"
}

variable "bldr_url" {
  default = "https://bldr.habitat.sh"
}

variable "release_channel" {
  default = "green"
}

variable "group" {
  default = "bluegreen"
}

variable "update_strategy" {
  default = "at-once"
}

variable "tag_dept" {
  default = "Product Marketing"
}

variable "tag_customer" {
  default = "Wave Demo"
}

variable "tag_project" {
  default = "Wave Demo"
}

variable "tag_application" {
  default = "parks-bluegreen"
}

variable "tag_contact" {
  default = "Nick Rycar"
}

variable "tag_ttl" {
  default = "100"
}
