terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}
provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
}
resource "docker_container" "nginx" {
  name = "nginx-server-1"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 80
  }
}
