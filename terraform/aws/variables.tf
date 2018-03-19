variable "aws_region" {
  default = "us-west-2"
}

variable "aws_profile" {
  default = "default"
}

variable "aws_key_pair_file" {
  default = "~/.ssh/james-us-west-2.pem"
}

variable "aws_key_pair_name" {
  default = "james-us-west-2"
}

variable "aws_image_user" {
  default = "ubuntu"
}

variable "habitat_origin" {
  default = "jamesc"
}

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
