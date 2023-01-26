variable "str" {
 type=string
 default ="127.0.0.1 gitlab.test"
}

resource "null_resource" "node1" {
 provisioner "local-exec" {
  command= "echo '${var.str}' > hosts.txt"
 }
}

output "str" {
 value=var.str
}
