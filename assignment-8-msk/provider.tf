terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"
        }
    }
    backend "s3" {
        bucket = "my-tfstate-bucket-donald123"
        key = "msk.terraform.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    region = "us-east-1"
}


