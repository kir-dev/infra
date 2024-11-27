variable "nginx-config-path" {
  type        = string
  default     = "/etc/nginx/conf.d/terraform.conf"
  description = "Path to the nginx config file"
}