resource "aws_security_group" "web" {
    name = "tf-web-sg"
    description = "allow SSH from my IP and HTTP from anywhere"
    vpc_id = data.aws_vpc.main.id

    ingress {
        description = "SSH from my IP"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress {
        description = "HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "tf-web-sg"
    }
}

resource "aws_network_acl" "public" {
    vpc_id = data.aws_vpc.main.id

    tags = {
        Name = "tf-public-nacl"
    }
}

resource "aws_network_acl_rule" "in_ssh" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 100
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22
}

resource "aws_network_acl_rule" "in_http" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 110
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 80
    to_port = 80
}

resource "aws_network_acl_rule" "in_ephemeral" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 120
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "out_all_tcp" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 100
    egress = true
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
}

resource "aws_network_acl_association" "public_a" {
    network_acl_id = aws_network_acl.public.id
    subnet_id = data.aws_subnets.public.ids[0]
}