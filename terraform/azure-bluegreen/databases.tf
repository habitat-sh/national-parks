# Create mongodb-1 instance
resource "azurerm_virtual_machine" "mongodb-1" {
  depends_on                    = ["azurerm_virtual_machine.initial-peer"]
  name                          = "${var.tag_application}-mongodb-1"
  location                      = "${var.azure_region}"
  resource_group_name           = "${azurerm_resource_group.rg.name}"
  network_interface_ids         = ["${azurerm_network_interface.nic.1.id}"]
  vm_size                       = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.tag_application}-mongodb-1-osdisk"
    vhd_uri       = "${azurerm_storage_account.stor.primary_blob_endpoint}${azurerm_storage_container.storcont.name}/${var.tag_application}-mongodb-1-osdisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.tag_application}-mongodb-1"
    admin_username = "${var.azure_image_user}"
    admin_password = "${var.azure_image_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false

    ssh_keys {
      path     = "/home/${var.azure_image_user}/.ssh/authorized_keys"
      key_data = "${file("${var.azure_public_key_path}")}"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.stor.primary_blob_endpoint}"
  }

  provisioner "habitat" {
    peer         = "${azurerm_public_ip.pip.0.ip_address}"
    use_sudo     = true
    service_type = "systemd"

    service {
      name     = "${var.habitat_origin}/np-mongodb"
      topology = "standalone"
      group    = "${var.group}"
      channel  = "${var.release_channel}"
      strategy = "${var.update_strategy}"
    }

    connection {
      host     = "${azurerm_public_ip.pip.1.ip_address}"
      user     = "${var.azure_image_user}"
      password = "${var.azure_image_password}"
    }
  }

  tags {
    X-Name        = "${var.tag_application}-${var.habitat_origin}-mongodb-1"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }
}
