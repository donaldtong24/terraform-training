resource "aws_vpc_peering_connection" "main_to_peer" {
    vpc_id = data.aws_vpc.main.id
    peer_vpc_id = aws_vpc.peer.id
    auto_accept = false

    tags = {
        Name = "tf-vpc-peering"
    }
}

resource "aws_vpc_peering_connection_accepter" "accept" {
    vpc_peering_connection_id = aws_vpc_peering_connection.main_to_peer.id
    auto_accept = true

    tags = {
        Name = "tf-vpc-peering"
    }
}