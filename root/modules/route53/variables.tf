variable "vpc_id" {
  description = "VPC ID to associate the private hosted zone"
  type        = string
}


variable "instances" {
  description = "Map of server names to private IP addresses"
  type        = map(string)
}

variable "zone_name" {
  description = "Domain name for the hosted zone "
  type        = string
}

