variable "ami_id" {
  description = "AMI ID for launching EC2 instances"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where EC2 instances will be deployed"
  type        = list(string)
}
