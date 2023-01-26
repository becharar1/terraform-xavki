variable "ssh_key" {
}
variable "ssh_user" {
}
variable "ssh_host"{
}
variable "root_password"{
}
resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_key)
    password     = var.root_password
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${var.root_password} | sudo -S apt update -qq >/dev/null",
      "echo ${var.root_password} | sudo -S apt install -qq -y nginx >/dev/null",
      "echo ${var.root_password} | sudo -S apt install -qq -y curl >/dev/null"
    ]
  }
  provisioner "file" {
    source = "nginx.conf"
    destination = "/tmp/default"
  }
  provisioner "remote-exec" {
     inline = [
      "echo ${var.root_password} | sudo -S cp -a /tmp/default /etc/nginx/sites-available/default",
      "echo ${var.root_password} | sudo -S service nginx restart"
     ]
  }
  provisioner "local-exec" {
   command="sshpass -p ${var.root_password} ssh ${var.ssh_user}@${var.ssh_host} curl http://localhost:6666 -o -"
  }
}
