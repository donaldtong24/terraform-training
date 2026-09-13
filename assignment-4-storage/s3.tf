resource "random_pet" "suffix" {
    length =2
}

resource "aws_s3_bucket" "app_data" {
    count =2
    #random_pet generates a readable two-word string like "informed-cricket"
    bucket = "tf-app-data-bucket-${random_pet.suffix.id}-${count.index}"

    tags = {
        Name = "tf-app-data-bucket-${count.index}"
    }
}

resource "aws_s3_bucket_versioning" "app_data" {
    count = 2
    bucket = aws_s3_bucket.app_data[count.index].id

    versioning_configuration{
        status = "Enabled"
    }
}