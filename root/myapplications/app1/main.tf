module "vpc" {
  source               = "../../modules/vpc"
  vpc_name             = "dlr_vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ec2" {
  source  = "../../modules/ec2"
  ami_id  = var.ami_id
  subnets = module.vpc.public_subnets
}

module "alb" {
  source         = "../../modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  instance_ids   = module.ec2.instance_ids
}
module "route53" {
  source    = "../../modules/route53"
  vpc_id    = module.vpc.vpc_id
  zone_name = var.private_zone_name  
  instances = {
    "server1"   = element(module.ec2.instance_ips, 0),
    "server2"   = element(module.ec2.instance_ips, 1),
    "interview" = element(module.ec2.instance_ips, 2)
  }
}
