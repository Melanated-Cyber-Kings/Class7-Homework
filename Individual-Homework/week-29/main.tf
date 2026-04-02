############################################
# VPC
############################################

module "vpc" {
  source                = "./modules/vpc"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr_a  = var.public_subnet_cidr_a
  public_subnet_cidr_b  = var.public_subnet_cidr_b
  private_subnet_cidr_a = var.private_subnet_cidr_a
  private_subnet_cidr_b = var.private_subnet_cidr_b
  az_a                  = var.az_a
  az_b                  = var.az_b
}

############################################
# Security Groups
############################################

module "security_groups" {
  source       = "./modules/security-groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  jenkins_port = var.jenkins_port
}

############################################
# ALB
############################################

module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  public_subnet_ids   = module.vpc.public_subnet_ids
  alb_sg_id           = module.security_groups.alb_sg_id
  vpc_id              = module.vpc.vpc_id
  jenkins_port        = var.jenkins_port
  acm_certificate_arn = var.acm_certificate_arn
}

############################################
# IAM (Instance Role + Instance Profile)
############################################

module "iam" {
  source                   = "./modules/iam"
  project_name             = var.project_name
  region                   = var.region
  jenkins_admin_secret_arn = module.secrets.jenkins_admin_secret_arn
  github_pat_secret_arn    = module.secrets.github_pat_secret_arn
}

############################################
# EC2 (Jenkins)
############################################

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  private_subnet_id = module.vpc.private_subnet_ids[0]
  jenkins_sg_id     = module.security_groups.jenkins_sg_id

  instance_type    = var.instance_type
  instance_profile = module.iam.instance_profile_name

  user_data = file("${path.module}/user-data.sh")

  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type
}

############################################
# Credentials for SSM or Secrets Manager
############################################

module "secrets" {
  source                 = "./modules/secrets"
  project_name           = var.project_name
  region                 = var.region
  jenkins_admin_password = var.jenkins_admin_password
  github_pat             = var.github_pat
  secret_backend         = var.secret_backend
  destroy_secrets        = var.destroy_secrets
}

############################################
# DNS (Route 53)
############################################

data "aws_route53_zone" "primary" {
  name         = "devlab405.click."
  private_zone = false
}

resource "aws_route53_record" "jenkins_app" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.app_subdomain}.${data.aws_route53_zone.primary.name}"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}
