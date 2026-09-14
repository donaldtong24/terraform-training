resource "aws_security_group" "db" {
    name = "tf-db-sg"
    description = "Allow MySQL from teh web security group only"
    vpc_id = data.aws_vpc.main.id

    ingress {
        description = "MySQL from web tier"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [data.aws_security_group.web.id] #the change from assignment 2
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "tf-db-sg"
    }
}