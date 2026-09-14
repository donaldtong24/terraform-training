output "db_endpoint" {
    value = aws_db_instance.app.endpoint
}

output "db_port"{
    value = aws_db_instance.app.port
}

output "db_password"{
    value = var.db_password
    sensitive = true
}