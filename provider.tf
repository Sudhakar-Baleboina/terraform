terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cloudfront-s3lab-sudhakar"
    key    = "terraform/nginx/terraform.tfstate"
    region = "us-east-1"
  }
}
