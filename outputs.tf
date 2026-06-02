output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.app.id
}

output "instance_ip" {
  description = "IP Publica de la instancia"
  value       = aws_instance.app.public_ip
}

output "ssh_key_name" {
  description = "Nombre de la clave SSH en AWS"
  value       = aws_key_pair.deployer_key.key_name
}
