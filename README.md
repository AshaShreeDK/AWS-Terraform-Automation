# Aws-Terraform-Automation
AWS Two-Tier Infrastructure Deployment Using Terraform:

This will deploys a two-tier architecture on AWS using Terraform. The architecture consists of a VPC with public subnets hosting an Application Load Balancer (ALB) and private subnets hosting EC2 instances. A private Route 53 hosted zone is configured to manage internal DNS records for the EC2 servers. The design improves security by isolating application servers from direct public access while still allowing public traffic to enter via the ALB.

Project Overview:The project implements a two-tier architecture on AWS using Terraform. It includes:A VPC (dlr_vpc) with a CIDR of 10.10.0.0/16.Public Subnets that host an Application Load Balancer (dlr_alb), which is configured to receive Internet traffic.Private Subnets that host EC2 instances (server1, server2, interview) serving as the application tier.A Route 53 Private Hosted Zone (dlrasha.cloud) for internal DNS resolution.

