terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

data "docker_registry_image" "remote-image" {
  name = "strm/helloworld-http:latest"
}

resource "docker_image" "local-image" {
  keep_locally  = true
  name          = data.docker_registry_image.remote-image.name
  pull_triggers = [data.docker_registry_image.remote-image.sha256_digest]
}

resource "docker_network" "service-network" {
  name = local.network-name
}

resource "docker_container" "backend" {
  count = 1

  image    = docker_image.local-image.image_id
  name     = "${local.module-name}-backend-${count.index}"
  hostname = "${local.module-name}-backend-${count.index}"
  ports {
    internal = 80
    external = var.external-port
  }
  networks_advanced {
    name = docker_network.service-network.name
  }
}