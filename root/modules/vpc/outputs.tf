output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.dlr_vpc.id
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = aws_subnet.dlr_public_subnet[*].id
}

output "private_subnets" {
  description = "IDs of the private subnets"
  value       = aws_subnet.dlr_private_subnet[*].id
}
