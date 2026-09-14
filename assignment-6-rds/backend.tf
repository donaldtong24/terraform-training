terraform {
    backend "s3" {
        bucket = "my-tfstate-bucket-donald123"
        key = "rds/terraform.tfstate"
        region = "us-east-1"
    }
}
