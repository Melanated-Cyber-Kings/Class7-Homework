# Provide SSH key pair for Linux virtual machine.

resource "tls_private_key" "linux-app1-server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "tls_public_key" "linux-app1-server" {
  private_key_pem = tls_private_key.linux-app1-server.private_key_pem
}

# output "private_key" {
#   value     = tls_private_key.linux-app1-server.private_key_pem
#   sensitive = true
# }

# output "public_key" {
#   value = data.tls_public_key.linux-app1-server.public_key_openssh
# }
