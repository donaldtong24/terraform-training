resource "aws_instance" "web" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnets.public.ids[0]
    vpc_security_group_ids = [data.aws_security_group.web.id]
    iam_instance_profile = aws_iam_instance_profile.ec2_s3_read.name
    key_name = var.key_name

    root_block_device {
        volume_size = 8
        volume_type = "gp2"
    }

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Hello World from Terraform EC2 $(hostname -f)</h1>" > /var/www/html/index.html
    EOF

    tags = {
        Name = "tf-web-server"
    }
}