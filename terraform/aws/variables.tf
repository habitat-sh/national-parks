# AWS Region
variable "aws_region" {
  default = "us-west-2"
}

# AWS profile name in ~/.aws/credentials
variable "aws_profile" {
  default = "default"
}

# SSH Key to use for EC2 instances
variable "aws_key_pair_file" {
  default = "~/.ssh/example.pem"
}

# AWS SSH key pair name
variable "aws_key_pair_name" {
  default = "example"
}

# AWS user for EC2 instances
variable "aws_image_user" {
  default = "ubuntu"
}

# Habitat origin name for packages
variable "habitat_origin" {
  default = "example"
}

# Environment name
variable "env" {
  default = "dev"
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