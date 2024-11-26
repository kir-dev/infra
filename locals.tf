locals {
  products = {
    # Docker production server
    "infra_lois" = {
      "product1" = {
        "description" = "Product 1"
      }
      "product2" = {
        "description" = "Product 2"
      }
    },
    # Docker staging server
    "infra_junior" = {},
    # KSZK Kubernetes cluster
    "infra_k8szk" = {}
  }
}