provider "google" {
  credentials = "${file("${var.gcp_credentials_file}")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

////////////////////////////////
// Firewalls

resource "google_compute_firewall" "national-parks-ingress" {
  name      = "national-parks-ingress"
  network   = "default"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080", "9631", "9638", "27017"]
  }

  allow {
    protocol = "udp"
    ports    = ["9631", "9638"]
  }
}

resource "google_compute_firewall" "national-parks-egress" {
  name      = "national-parks-egress"
  network   = "default"
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080", "9631", "9638", "27017"]
  }

  allow {
    protocol = "udp"
    ports    = ["9631", "9638"]
  }
}

////////////////////////////////
// Initial Peer

resource "google_compute_instance" "initial-peer" {
  name         = "initial-peer"
  machine_type = "f1-micro"
  zone         = "${var.gcp_zone}"

  tags = ["national-parks"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20171011"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  count = 1

  lifecycle = {
    create_before_destroy = true
  }

  connection {
    user        = "${var.gcp_image_user}"
    private_key = "${file("${var.gcp_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.initial_peer.rendered}"
    destination = "/home/${var.gcp_image_user}/hab-sup.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.gcp_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
    ]
  }
}

////////////////////////////////
// Instances

resource "google_compute_instance" "np-mongodb" {
  name         = "np-mongodb"
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_zone}"

  tags = ["national-parks"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20171011"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  count = 1

  lifecycle = {
    create_before_destroy = true
  }

  connection {
    user        = "${var.gcp_image_user}"
    private_key = "${file("${var.gcp_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.sup_service.rendered}"
    destination = "/home/${var.gcp_image_user}/hab-sup.service"
  }

  provisioner "local-exec" {
    command = "scp -oStrictHostKeyChecking=no -i ${var.gcp_private_key} ${var.local_hart_dir}/${var.np_mongodb_hart} ${var.gcp_image_user}@${self.network_interface.0.access_config.0.assigned_nat_ip}:/home/${var.gcp_image_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.gcp_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
      "sudo hab pkg install /home/${var.gcp_image_user}/${var.np_mongodb_hart}",
      "sudo hab svc load echohack/np-mongodb --group prod --strategy at-once",
    ]
  }
}

resource "google_compute_instance" "national-parks" {
  name         = "national-parks"
  machine_type = "n1-standard-1"
  zone         = "${var.gcp_zone}"

  tags = ["national-parks"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20171011"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  count = 1

  lifecycle = {
    create_before_destroy = true
  }

  connection {
    user        = "${var.gcp_image_user}"
    private_key = "${file("${var.gcp_private_key}")}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.sup_service.rendered}"
    destination = "/home/${var.gcp_image_user}/hab-sup.service"
  }

  provisioner "local-exec" {
    command = "scp -oStrictHostKeyChecking=no -i ${var.gcp_private_key} ${var.local_hart_dir}/${var.national_parks_hart} ${var.gcp_image_user}@${self.network_interface.0.access_config.0.assigned_nat_ip}:/home/${var.gcp_image_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.gcp_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
      "sudo hab pkg install /home/${var.gcp_image_user}/${var.national_parks_hart}",
      "sudo hab svc load echohack/national-parks --group prod --bind database:np-mongodb.prod --strategy at-once",
    ]
  }
}

////////////////////////////////
// Templates

data "template_file" "initial_peer" {
  template = "${file("${path.module}/templates/hab-sup.service")}"

  vars {
    flags = "--auto-update --listen-gossip 0.0.0.0:9638 --listen-http 0.0.0.0:9631 --permanent-peer"
  }
}

data "template_file" "sup_service" {
  template = "${file("${path.module}/templates/hab-sup.service")}"

  vars {
    flags = "--auto-update --peer ${google_compute_instance.initial-peer.network_interface.0.address} --listen-gossip 0.0.0.0:9638 --listen-http 0.0.0.0:9631"
  }
}

data "template_file" "install_hab" {
  template = "${file("${path.module}/templates/install-hab.sh")}"
}
