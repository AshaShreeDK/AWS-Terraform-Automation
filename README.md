# Aws-Terraform-Automation
AWS Two-Tier Infrastructure Deployment Using Terraform:

This will deploys a two-tier architecture on AWS using Terraform. The architecture consists of a VPC with public subnets hosting an Application Load Balancer (ALB) and private subnets hosting EC2 instances. A private Route 53 hosted zone is configured to manage internal DNS records for the EC2 servers. The design improves security by isolating application servers from direct public access while still allowing public traffic to enter via the ALB.

