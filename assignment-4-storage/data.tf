data "aws_instance" "web" {
    filter {
        name = "tag:Name"
        values = ["tf-web-server"]
    }
    # makes sure the instance is running.
    filter {
        name ="instance-state-name"
        values = ["running"]
    }
}