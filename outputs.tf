output "public_ip_vm" {
  value = module.public_ip.ip_address
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${module.public_ip.ip_address}"
}