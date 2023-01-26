variable "hosts" {
 default ={
   "127.0.0.2" = "localhost.gitlab.local.me2"
   "192.169.1.160 "= "gitlab.test"
   "192.16.1.178" = "prometheus.test"
 }
}

resource "null_resource" "hosts" {
 for_each=var.hosts
 triggers = {
  foo=each.value
 }
 provisioner "local-exec" {
  command= "echo '${each.key} ${each.value}'  >> hosts.txt"
 }
}
