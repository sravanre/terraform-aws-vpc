terraform {
  backend "s3" {
    bucket         = "terraform-aws-s3-bucket3517673"
    region         = "us-east-1"
    key            = "terraform-aws-vpc/ALB-EC2/terraform.tfstate"
    use_lockfile = true
    encrypt = true
  }
  required_version = ">= 1.1.9"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}