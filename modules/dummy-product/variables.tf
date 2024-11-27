variable "image-name" {
  type        = string
  description = "Name of the image to use"
  default     = "strm/helloworld-http:latest"
}

variable "external-port" {
  type        = string
  description = "External port to access the service"
}

variable "deployment-id" {
  type        = string
  description = "Deployment ID (prefix of docker resource names)"
  validation {
    condition     = length(var.deployment-id) > 0
    error_message = "Deployment ID must not be empty"
  }
}