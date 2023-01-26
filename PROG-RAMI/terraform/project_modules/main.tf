variable "ssh_key" {
} 
variable "ssh_user" {
}
variable "ssh_host"{
}
variable "root_password"{
}
module "docker_install"{
  source 	= "./modules/docker_install"
  ssh_host 	= var.ssh_host
  ssh_user	= var.ssh_user
  ssh_key	= var.ssh_key
  root_password = var.root_password
}
module "docker_run"{
  source        = "./modules/docker_run"
  ssh_host      = var.ssh_host
}
