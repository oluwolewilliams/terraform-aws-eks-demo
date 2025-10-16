# outputs.tf

# List: public IPs for each web instance
output "web_public_ips" {
  description = "Public IPv4 addresses for the web instances"
  value       = [for inst in aws_instance.web : inst.public_ip]
}

# List: public DNS names for each web instance
output "web_public_dns" {
  description = "Public DNS names for the web instances"
  value       = [for inst in aws_instance.web : inst.public_dns]
}

# Map: instance ID => public DNS
output "web_id_to_dns" {
  description = "Map of instance ID to public DNS"
  value       = { for inst in aws_instance.web : inst.id => inst.public_dns }
}

# (Optional) Splat syntax alternates
output "web_public_ips_splat" {
  value = aws_instance.web[*].public_ip
}

output "web_public_dns_splat" {
  value = aws_instance.web[*].public_dns
}

# (Optional) Structured objects per instance
output "web_instances" {
  value = [
    for inst in aws_instance.web : {
      id         = inst.id
      az         = inst.availability_zone
      public_ip  = inst.public_ip
      public_dns = inst.public_dns
    }
  ]
}
