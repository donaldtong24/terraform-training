resource "aws_vpc" "peer" {
    cidr_block = "10.1.0.0/16"

    tags = {
        Name = "tf-peer-vpc"
    }
}

resource "aws_subnet" "peer" {
    vpc_id            = aws_vpc.peer.id
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "tf-peer-subnet-1"
    }
}