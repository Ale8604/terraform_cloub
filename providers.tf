terraform {
  required_version = "~> 1.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.23.0, <6.27.0"
    }
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  # Configuration options
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}



