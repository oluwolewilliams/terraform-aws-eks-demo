output "instance_public_ip" {
  description = "Public IP of the web instance"
  sensitive   = false
  value       = aws_instance.web.public_ip

}
