data "aws_vpc" "main" {
    filter {
        name = "tag:Name"
        values = ["tf-main-vpc"]
    }
}

data "aws_security_group" "web" {
    filter {
        name = "tag:Name"
        values = ["tf-web-sg"]
    }
    vpc_id =data.aws_vpc.main.id
}