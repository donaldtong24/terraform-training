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

data "aws_security_group" "web" {
    filter {
        name = "tag:Name"
        values = ["tf-web-sg"]
    }
    vpc_id = data.aws_vpc.main.id
}

data "aws_ami" "amazon_linux_2"{
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}