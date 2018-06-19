provider "google" {
  credentials = "${file("${var.gke_credentials_file}")}"
  project     = "${var.gke_project}"                     #TODO
  region      = "${var.gke_region}"
}

data "google_compute_zones" "available" {}

resource "google_container_cluster" "primary" {
  name               = "${var.habitat_origin}-${var.tag_application}-${var.tag_customer}-cluster"
  zone               = "${data.google_compute_zones.available.names[0]}"
  initial_node_count = 3

  master_auth {
    username = "${var.gke_basic_username}"
    password = "${var.gke_basic_password}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
