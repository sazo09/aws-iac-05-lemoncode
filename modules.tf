# ====================================
# VPC Módulo - terraform-aws-modules
# ====================================
# Este módulo crea automáticamente:
# - VPC con CIDR block
# - Internet Gateway
# - Subnets públicas
# - Route tables
# - Asociaciones de rutas

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  # Configuración básica
  name = local.vpc_name
  cidr = var.vpc_cidr

  # Availability zones - especificamos us-east-1a para t3.micro
  azs = ["us-east-1a"]

  # Subnets públicas
  public_subnets = [var.public_subnet_cidr]
  
  # Configuración de subnets públicas
  map_public_ip_on_launch = true
  enable_dns_hostnames    = true
  enable_dns_support      = true

  # Internet Gateway
  create_igw = true

  # Tags comunes
  tags = local.common_tags
  
  # Tags específicos para recursos
  vpc_tags = {
    Name = local.vpc_name
  }
  
  igw_tags = {
    Name = local.igw_name
  }
  
  public_subnet_tags = {
    Name = local.subnet_name
  }
  
  public_route_table_tags = {
    Name = local.route_table_name
  }
}
