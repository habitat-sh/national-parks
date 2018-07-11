////////////////////////////////
// Required variables. Create a terraform.tfvars.

variable "aws_key_pair_name" {
  description = "The name of the key pair to associate with your instances. Required for SSH access."
}

variable "aws_key_pair_file" {
  description = "The path to the file on disk for the private key associated with the AWS key pair associated with your instances. Required for SSH access."
}

variable "aws_region" {
  description = "The name of the selected AWS region / datacenter. Example: us-west-2"
}

variable "tag_dept" {
  description = "The department at your company responsible for these resources."
}

variable "tag_contact" {
  description = "The email address associated with the person or team that is standing up this resource. Used to contact if problems occur."
}

variable "habitat_origin" {
  description = "Your origin on bldr.habitat.sh where your national-parks packages are located."
}

////////////////////////////////
// AWS

variable "aws_profile" {
  default     = "default"
  description = "The AWS profile to use from your ~/.aws/credentials file."
}

variable "aws_ami_user" {
  default     = "centos"
  description = "The user used for SSH connections and path variables."
}

variable "aws_ami_id" {
  default     = ""
  description = "The AMI id to use for the base image for instances. Leave blank to auto-select the latest high performance CentOS 7 image."
}

variable "aws_instance_type" {
  default     = "m5.large"
  description = "The AWS instance types (sizes)."
}

variable "tag_customer" {
  default     = "Chef"
  description = "The customer who you are creating this infrastructure for."
}

variable "tag_project" {
  default     = ""
  description = "The project this instance is associtated with."
}

variable "tag_application" {
  default     = "national-parks"
  description = "The application associated with these instances."
}

variable "tag_ttl" {
  default     = "8"
  description = "The time to live. Used by reaper scripts to determine if instances have lived for too long."
}

////////////////////////////////
// Habitat
variable "release_channel" {
  default     = "stable"
  description = "The Habitat channel which national-parks updates on."
}

variable "group" {
  default     = "dev"
  description = "The Habitat service group."
}

variable "update_strategy" {
  default     = "at-once"
  description = "The Habitat update strategy."
}
