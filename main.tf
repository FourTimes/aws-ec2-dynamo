terraform {
  backend "local" {}
  required_version = ">= 0.14"
}

provider "aws" {}

locals {
  system_name = "vouch-operations"
}
