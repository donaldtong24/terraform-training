output "vpc_peering_id" {
    value = aws_vpc_peering_connection.main_to_peer.id
}

output "peer_vpc_id" {
    value = aws_vpc.peer.id
}