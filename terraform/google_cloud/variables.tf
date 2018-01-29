variable "gcp_region" {
  default = "us-west1"
}

variable "gcp_zone" {
  default = "us-west1-a"
}

variable "gcp_credentials_file" {
  default = "/Users/echohack/.gcp/habitat-kubernetes-playland-6970193c95fc.json"
}

variable "gcp_project" {
  default = "habitat-kubernetes-playland"
}

variable "gcp_image_user" {
  default = "echohack"
}

variable "gcp_private_key" {
  default = "/Users/echohack/.ssh/google_compute_engine_decrypt"
}

variable "local_hart_dir" {
  default = "/Users/echohack/code/national-parks/results"
}

variable "np_mongodb_hart" {
  default = "echohack-np-mongodb-3.2.9-20171026032947-x86_64-linux.hart"
}

variable "national_parks_hart" {
  default = "echohack-national-parks-5.6.0-20171026043832-x86_64-linux.hart"
}
