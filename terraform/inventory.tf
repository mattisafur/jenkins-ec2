resource "local_file" "inventory_file" {
  content = templatefile("inventory.tpl", {
    ip_address = aws_instance.jenkins.public_ip
  })
  filename = "../ansible/inventory.ini"
}
