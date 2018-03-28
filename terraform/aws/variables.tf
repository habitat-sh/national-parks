variable "aws_region" {
  default = "us-west-2"
}

variable "aws_profile" {
  default = "default"
}

variable "aws_key_pair_file" {
  default = "~/.ssh/example.pem"
}

variable "aws_key_pair_name" {
  default = "example"
}

variable "aws_image_user" {
  default = "ubuntu"
}

variable "habitat_origin" {
  default = "example"
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
