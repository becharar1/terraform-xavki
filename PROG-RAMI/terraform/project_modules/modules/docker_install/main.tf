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
      "yum update -y -qq >/dev/null",
      "yum install curl -y -qq >/dev/null",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "chmod 755 get-docker.sh",
      "./get-docker.sh >/dev/null >/dev/null"
    ]
  }

  provisioner "file" {
   source      = "${path.module}/startup-options.conf"
    destination = "/tmp/startup-options.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /etc/systemd/system/docker.service.d/",
      "cp /tmp/startup-options.conf /etc/systemd/system/docker.service.d/startup_options.conf",
      "systemctl daemon-reload",
      "systemctl restart docker",
      "usermod -aG docker root"
    ]
  }
}
