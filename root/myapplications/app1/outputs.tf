output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "alb_dns" {
  description = "DNS name of the ALB"
  value       = module.alb.dlr_alb_dns
}

output "route53_zone_id" {
  description = "Route53 Private Hosted Zone ID"
  value       = module.route53.private_zone_id
}
