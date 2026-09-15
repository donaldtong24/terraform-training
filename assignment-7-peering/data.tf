data "aws_vpc" "main" {
    filter {
        name = "tag:Name"
        values = ["tf-main-vpc"]
    }
}

data "aws_route_table" "main_public" {
    filter {
        name = "tag:Name"
        values = ["tf-public-rt"]
    }
}