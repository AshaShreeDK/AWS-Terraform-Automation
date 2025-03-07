variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "instance_ids" {
  description = "List of EC2 instance IDs for target group attachments"
  type        = list(string)
}
