terraform {
  required_version = ">= 1.1"

  required_providers {
    # Update these to reflect the actual requirements of your module
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
