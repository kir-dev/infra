terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# data "docker_registry_image" "remote-image" {
#   name = var.image-name
# }

resource "docker_image" "local-image" {
  keep_locally = true # multiple instances can use the same image
  name         = var.image-name
  # pull_triggers = [data.docker_registry_image.remote-image.sha256_digest]
}

resource "docker_network" "service-network" {
  name = local.network-name
}

resource "docker_container" "backend" {
  image                 = docker_image.local-image.image_id
  name                  = local.backend-name
  restart               = "unless-stopped"
  destroy_grace_seconds = 20 # terraform fails after 30 seconds

  env = ["PORT=80"]

  ports {
    internal = 80
    external = var.external-port
  }

  network_mode = "bridge" # fix: docker bug https://github.com/kreuzwerker/terraform-provider-docker/issues/603

  networks_advanced {
    name = docker_network.service-network.name
  }
}

output "backend-container" {
  value = docker_container.backend.id
}