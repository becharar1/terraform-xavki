variable "hosts" {
 default = ["127.0.0.1 localhost2","192.169.1.160 gitlab.test"]
}

resource "null_resource" "hosts" {
 count="${length(var.hosts)}"
 triggers = {
  foo=element(var.hosts, count.index)
 }
 provisioner "local-exec" {
  command= "echo '${element(var.hosts, count.index)}'  >> hosts.txt"
 }
}
