terraform {
  required_providers {
    tfcoremock = {
      source = "hashicorp/tfcoremock"
    }
  }

#   testing {
#     module_registry_source = "app.terraform.io/liamcervante/simple-copy/tfcoremock"
#   }
}

data "tfcoremock_simple_resource" "external" {
  id = var.id
}

resource "tfcoremock_simple_resource" "internal" {
  string = data.tfcoremock_simple_resource.external.string
  number = data.tfcoremock_simple_resource.external.number
  bool   = data.tfcoremock_simple_resource.external.bool
}
