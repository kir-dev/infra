locals {
  services = {
    "service1.example.com" = {
      source     = "../../modules/dummy1"
      local-port = 8080
    }
    "service2.example.com" = {
      source     = "../../modules/dummy2"
      local-port = 8081
    }
  }

  nginx_config = join("\n\n", [
    for service, details in local.services : <<-EOT
    server {
        listen 80;
        # listen [::]:80;
        server_name ${service};

        location / {
            proxy_pass http://localhost:${details.local-port};
            # proxy_set_header Host $host;
            # proxy_set_header X-Real-IP $remote_addr;
            # proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            # proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
    EOT
  ])
}