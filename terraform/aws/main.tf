# Make sure the correct version of terraform is installed
terraform {
  required_version = "> 0.11.0"
}

provider "aws" {
  profile = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
  region     = "${var.aws_region}"
}


resource "random_id" "national_parks_id" {
  byte_length = 4
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  # Tag our vpc with the keyname used to identify it
  tags {
    Name = "${random_id.national_parks_id.hex}-national-parks"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

////////////////////////////////
// Firewalls

resource "aws_security_group" "national-parks" {
  name        = "${var.aws_key_pair_name}-${random_id.national_parks_id.hex}-national-parks"
  description = "National Parks"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9631
    to_port     = 9631
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9638
    to_port     = 9638
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9631
    to_port     = 9631
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9638
    to_port     = 9638
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    X-Contact     = "The Example Maintainer <maintainer@example.com>"
    X-Application = "national-parks"
    X-ManagedBy   = "Terraform"
  }
}

////////////////////////////////
// Initial Peer

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20180109*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "initial-peer" {
  connection {
    user        = "${var.aws_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "m4.large"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.default.id}"
  vpc_security_group_ids      = ["${aws_security_group.national-parks.id}"]
  associate_public_ip_address = true

  tags {
    Name      = "national_parks_${random_id.national_parks_id.hex}_initial_peer"
    X-Dept    = "SCE"
    X-Contact = "${var.aws_key_pair_name}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.initial_peer.rendered}"
    destination = "/home/${var.aws_image_user}/hab-sup.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.aws_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
    ]
  }
}

////////////////////////////////
// Instances

resource "aws_instance" "np-mongodb" {
  connection {
    user        = "${var.aws_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "m4.large"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet_id.national-parks.id}"
  vpc_security_group_ids      = ["${aws_security_group.national-parks.id}"]
  associate_public_ip_address = true

  tags {
    Name      = "national_parks_${random_id.national_parks_id.hex}_np_mongodb"
    X-Dept    = "SCE"
    X-Contact = "${var.aws_key_pair_name}"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.sup_service.rendered}"
    destination = "/home/${var.aws_image_user}/hab-sup.service"
  }

  provisioner "local-exec" {
    command = "scp -oStrictHostKeyChecking=no -i ${var.aws_key_pair_file} ${var.local_hart_dir}/${var.np_mongodb_hart} ${var.aws_image_user}@${self.public_ip}:/home/${var.aws_image_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.aws_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
      "sudo hab svc load ${var.habitat_origin}/np-mongodb --group prod --strategy at-once --",
    ]
  }
}

resource "aws_instance" "national-parks" {
  connection {
    user        = "${var.aws_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "m4.large"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${data.aws_subnet_ids.national-parks.ids[1]}"
  vpc_security_group_ids      = ["${aws_security_group.national-parks.id}"]
  associate_public_ip_address = true

  tags {
    Name      = "national_parks_${random_id.national_parks_id.hex}_national_parks"
    X-Dept    = "SCE"
    X-Contact = "echohack"
  }

  provisioner "file" {
    content     = "${data.template_file.install_hab.rendered}"
    destination = "/tmp/install_hab.sh"
  }

  provisioner "file" {
    content     = "${data.template_file.sup_service.rendered}"
    destination = "/home/${var.aws_image_user}/hab-sup.service"
  }

  provisioner "local-exec" {
    command = "scp -oStrictHostKeyChecking=no -i ${var.aws_key_pair_file} ${var.local_hart_dir}/${var.national_parks_hart} ${var.aws_image_user}@${self.public_ip}:/home/${var.aws_image_user}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --group hab",
      "sudo useradd -g hab hab",
      "chmod +x /tmp/install_hab.sh",
      "sudo /tmp/install_hab.sh",
      "sudo mv /home/${var.aws_image_user}/hab-sup.service /etc/systemd/system/hab-sup.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start hab-sup",
      "sudo systemctl enable hab-sup",
      "sudo hab svc load ${var.habitat_origin}/national-parks --group prod --bind database:np-mongodb.prod --strategy at-once",
    ]
  }
}

////////////////////////////////
// Templates

data "template_file" "initial_peer" {
  template = "${file("${path.module}/../templates/hab-sup.service")}"

  vars {
    flags = "--auto-update --listen-gossip 0.0.0.0:9638 --listen-http 0.0.0.0:9631 --permanent-peer"
  }
}

data "template_file" "sup_service" {
  template = "${file("${path.module}/../templates/hab-sup.service")}"

  vars {
    flags = "--auto-update --peer ${aws_instance.initial-peer.private_ip} --listen-gossip 0.0.0.0:9638 --listen-http 0.0.0.0:9631"
  }
}

data "template_file" "install_hab" {
  template = "${file("${path.module}/../templates/install-hab.sh")}"
}
