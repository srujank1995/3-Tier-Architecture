# outputs.tf
output "app_server_public_ip" {
  description = "Public IP of the application server"
  value       = aws_instance.main_server.public_ip
}

output "db_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.database.endpoint
}
