resource "aws_security_group" "msk" {
    name = "tf-msk-sg"
    description = "allow kafka traffic from web tier and between brokers"
    vpc_id = data.aws_vpc.main.id
    ingress {
        description = "kafka paintext from web tier"
        from_port = 9092
        to_port = 9092
        protocol = "tcp"
        security_groups = [data.aws_security_group.web.id]

    }

    ingress {
        description = "kafka tls from web tier"
        from_port = 9094
        to_port = 9094
        protocol = "tcp"
        security_groups = [data.aws_security_group.web.id]

    }

    ingress{
        description = "broker to broker all traffic within this sg"
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true #allows traffic from any resource in this security group to any other resource in this security group

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "tf-msk-sg"
    }
}