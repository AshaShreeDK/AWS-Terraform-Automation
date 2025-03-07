output "dlr_alb_dns" {
  description = "DNS name of the ALB"
  value       = aws_lb.dlr_alb.dns_name
}

output "dlr_alb_sg_id" {
  description = "The ID of the new ALB security group"
  value       = aws_security_group.dlr_alb_sg.id
}
