# ===================================
# TERRAFORM.TFVARS - Valores de variables
# ===================================
# Este archivo contiene los VALORES específicos para tu entorno
# ¡IMPORTANTE! Cambiar my_ip a tu IP real (nunca usar 0.0.0.0/0 en SSH en producción)

aws_region   = "us-east-1"
environment  = "learning"
project_name = "aws-iac-05-lemoncode"

# CAMBIAR ESTO: Reemplaza con tu IP pública real
# Para obtener tu IP: curl https://api.ipify.org
# Ejemplo: my_ip = "88.25.123.45/32"
my_ip = "0.0.0.0/0"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"

common_tags = {
  CreatedBy   = "Terraform"
  Environment = "learning"
  Project     = "aws-iac-05-lemoncode"
  Owner       = "Estudiante"
}

public_key_path = "~/.ssh/aws-ejercicio.pub"