locals {
  ports = {
    "service1.example.com" = 8080
    "service2.example.com" = 8081
  }

  nginx_config = join("\n\n", [
    for service, port in local.ports : <<-EOT
server {
    listen 80;
    listen [::]:80;
    server_name ${service};

    location / {
        proxy_pass http://localhost:${port};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
    EOT
    ], [<<-EOT
server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name _;

  location / { 
    return 404;
  }
}
  EOT
  ])
}