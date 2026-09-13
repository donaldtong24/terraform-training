data "aws_vpc" "main" {
    filter {
        name = "tag:Name"
        values = ["tf-main-vpc"]
    }
}

data "aws_subnets" "public" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.main.id]
    }


    tags = {
        Name = "tf-public-subnet-*"
    }
}