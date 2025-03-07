output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.servers[*].id
}

output "instance_ips" {
  description = "Private IPs of the EC2 instances"
  value       = aws_instance.servers[*].private_ip
}
