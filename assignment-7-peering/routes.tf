# route in the existing main public route table (assignment 1 owns the table itself)
resource "aws_route" "main_to_peer" {
    route_table_id = data.aws_route_table.main_public.id
    destination_cidr_block = aws_vpc.peer.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.main_to_peer.id
}

# new route table for the peer VPC, owned by this assignment
resource "aws_route_table" "peer" {
    vpc_id = aws_vpc.peer.id

    tags = {
        Name = "tf-peer-rt"
    }
}

resource "aws_route_table_association" "peer" {
    subnet_id = aws_subnet.peer.id
    route_table_id = aws_route_table.peer.id
}

resource "aws_route" "peer_to_main" {
    route_table_id = aws_route_table.peer.id
    destination_cidr_block = data.aws_vpc.main.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.main_to_peer.id
}