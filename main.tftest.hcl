
provider "tfcoremock" {}

provider "tfcoremock" {
  alias = "data"

  resource_directory = "terraform.data"
}

run "setup" {
  providers = {
    tfcoremock = tfcoremock.data
  }

  module {
    source = "./testing/setup"
  }
}

run "test" {

  variables {
    id = run.setup.id
  }

  providers = {
    tfcoremock = tfcoremock
  }

  assert {
    condition     = tfcoremock_simple_resource.internal.string == run.setup.string
    error_message = "String value was not copied correctly."
  }

  assert {
    condition     = tfcoremock_simple_resource.internal.number == run.setup.number
    error_message = "Number value was not copied correctly."
  }

  assert {
    condition     = tfcoremock_simple_resource.internal.bool == run.setup.bool
    error_message = "Boolean value was not copied correctly."
  }
}
