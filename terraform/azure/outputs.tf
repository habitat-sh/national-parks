output "pip-initial_peer" {
  value = "${azurerm_public_ip.pip.0.ip_address}",
}

output "pip-mongodb" {
  value = "${azurerm_public_ip.pip.1.ip_address}",
}

output "pip-np_app" {
  value = "${azurerm_public_ip.pip.2.ip_address}",
}
