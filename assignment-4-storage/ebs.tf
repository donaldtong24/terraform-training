resource "aws_ebs_volume" "extra" {
    availability_zone = data.aws_instance.web.availability_zone
    size = 1
    type = "gp2"

    tags = {
        Name = "tf-extra-data-volume"
    }
}

resource "aws_volume_attachment" "extra" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.extra.id
    instance_id = data.aws_instance.web.id
}