terraform {
    backend "s3" {
        bucket = "my-tfstate-bucket-donald123"
        key = "monitoring/terraform.tfstate"
        region = "us-east-1"
    }
}