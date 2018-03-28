output "instance_ips" {
  value = ["${azurerm_public_ip.pip.*.ip_address}"]
}
