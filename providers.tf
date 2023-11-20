terraform {
  cloud {
    organization = "sanjarbey"

    workspaces {
      name = "cloud2021"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}