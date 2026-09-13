data "aws_instance" "web" {
    filter {
        name = "tag:Name"
        values = ["tf-web-server"]
    }
}