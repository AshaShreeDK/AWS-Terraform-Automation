
output "public_zone_id" {
  description = "The ID of the public hosted zone"
  value       = aws_route53_zone.public_zone.zone_id
}
