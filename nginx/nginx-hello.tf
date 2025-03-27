terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

#Pull the nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

#Create the container from the image
resource "docker_container" "grigor_nginx" {
  image = docker_image.nginx.name
  name  = "grigor_nginx"

  ports {
    internal = 80
    external = 8000
  }
}