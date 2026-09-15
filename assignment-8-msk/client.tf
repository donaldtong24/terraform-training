resource "aws_instance" "kafka_client" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t3.small"
    subnet_id = data.aws_subnets.public.ids[0]
    vpc_security_group_ids = [data.aws_security_group.web.id]
    key_name = "tf-training-key"

    tags = {
        Name = "tf-kafka-client"
    }
}