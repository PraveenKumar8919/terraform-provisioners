terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"    # this version is aws provder version
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}