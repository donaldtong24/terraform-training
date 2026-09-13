terraform {
    backend "s3" {
        bucket = "my-tfstate-bucket-donald123"
        key = "storage/terraform.tfstate"
        region = "us-east-1"
    }
}