output "instance_id" {
  value = aws_instance.name.id
}
output "public_ip" {
  description = "Public IP address, if assigned"
  value       = aws_instance.name.public_ip
}
output "private_ip" {
  description = "Private IP address, if assigned"
  value       = aws_instance.name.private_ip
}