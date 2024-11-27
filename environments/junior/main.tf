terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
}

resource "local_file" "nginx-config" {
  content  = local.nginx_config
  filename = var.nginx-config-path

  provisioner "local-exec" {
    when       = create
    command    = "nginx -t && nginx -s reload"
    on_failure = fail
  }


  provisioner "local-exec" {
    when       = destroy
    command    = "nginx -t && nginx -s reload"
    on_failure = fail
  }
}

module "dummy1" {
  source        = "../../modules/dummy1"
  external-port = local.services["service1.example.com"].local-port
}

module "dummy2" {
  source        = "../../modules/dummy2"
  external-port = local.services["service2.example.com"].local-port
}

