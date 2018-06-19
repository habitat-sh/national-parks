variable "gke_credentials_file" {
  default = "/path/to/file.json"
}

variable "gke_project" {
  default = "my-project-id"
}

variable "gke_region" {
  default = "us-west1"
}

variable "habitat_origin" {}

variable "tag_application" {
  default = "national-parks"
}

variable "tag_contact" {}
variable "tag_dept" {}
variable "tag_customer" {}

variable "tag_project" {
  default = "hab"
}

variable "gke_basic_username" {
  default = "admin"
}

variable "gke_basic_password" {}
