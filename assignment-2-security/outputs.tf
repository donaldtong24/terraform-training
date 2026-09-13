output "web_sg_id" {
    value = aws_security_group.web.id
}

output "public_nacl_id" {
    value = aws_network_acl.public.id
}