variable "aws_region" {
  default = "us-west-2"
}

variable "aws_profile" {
  default = "default"
}

variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "aws_key_pair_file" {
  default = "~/.ssh/id_rsa"
}

variable "aws_key_pair_name" {
  default = ""
}

variable "aws_image_user" {
  default = "ubuntu"
}

#
# Habitat Variables
# 

variable "habitat_origin" {
  default = "core"
}

variable "env" {
  default = "dev"
}

variable "bldr_url" {
  default = "https://bldr.habitat.sh"
}

variable "release_channel" {
  default "stable"
}
