variable "aws_region" {}

variable "aws_profile" {
  default = "default"
}

variable "aws_key_pair_file" {}

variable "aws_key_pair_name" {}

variable "aws_image_user" {
  default = "ubuntu"
}

variable "habitat_origin" {}

variable "env" {
  default = "dev"
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
