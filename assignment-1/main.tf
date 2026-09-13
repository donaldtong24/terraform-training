resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "tf-main-vpc"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id =aws_vpc.main.id

    tags = {
        Name = "tf-main-igw"
    }
}

