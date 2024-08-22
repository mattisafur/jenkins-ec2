resource "local_file" "inventory_file" {
  content = templatefile("inventory.tpl", {
    master_ip = aws_instance.jenkins_master.public_ip
  })
  filename = "../ansible/inventory.ini"
}
