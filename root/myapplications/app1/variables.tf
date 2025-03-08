variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.10.10.0/16"  # /28 block provides 2^(32-28) = 16 IP addresses.
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.10.10.0/28", "10.10.10.16/28", "10.10.10.32/28"]
    # (  10.10.10.0 - 10.10.10.15)
    # ( 10.10.10.16 - 10.10.10.31)
    # ( 10.10.10.32 - 10.10.10.47)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.10.10.48/28", "10.10.10.64/28", "10.10.10.80/28"]
  #(10.10.10.48 - 10.10.10.63)
  # (10.10.10.64 - 10.10.10.79)
  # (10.10.10.80 - 10.10.10.95)
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0ef0a3b4303b17ec5"
}

variable "private_zone_name" {
  description = "Private hosted zone name" 
  default     = "dlrasha.cloud"
}
