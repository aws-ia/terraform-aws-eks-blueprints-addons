terraform {
  required_version = ">= 1.0.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0, < 5.0.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 0.24.0"
    }
  }
}
