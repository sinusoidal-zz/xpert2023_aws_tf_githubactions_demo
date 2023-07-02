//test
provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = "1.5.1"

  backend "s3" {
    region = "eu-west-3"
    bucket = "xpertsummit-remote-state-development-student35"
    key    = "terraform.tfstate"
  }
}
