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

module "service-1" {
  source        = "../../modules/dummy-product"
  external-port = local.ports["service1.example.com"]
  deployment-id = "service-1"
}

module "service-2" {
  source        = "../../modules/dummy-product"
  external-port = local.ports["service2.example.com"]
  deployment-id = "service-2"
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


