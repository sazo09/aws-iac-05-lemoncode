# ===================================
# TERRAFORM.TFVARS - Valores de variables
# ===================================
# Este archivo contiene los VALORES específicos para tu entorno

aws_region   = "us-east-1"
environment  = "learning"
project_name = "aws-iac-05-lemoncode"

# IMPORTANTE: my_ip se inyecta via variable de entorno (TF_VAR_my_ip)
# NO hardcodear credenciales o datos sensibles en este archivo
# Ejecutar ANTES de terraform plan:
#   export TF_VAR_my_ip="$(curl -s https://api.ipify.org)/32"
#   terraform plan

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"

common_tags = {
  CreatedBy   = "Terraform"
  Environment = "learning"
  Project     = "aws-iac-05-lemoncode"
  Owner       = "Estudiante"
}

# public_key_path usa el valor default de variables.tf (~/.ssh/terraform-aws-key.pub)