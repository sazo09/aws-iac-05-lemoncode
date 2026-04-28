# ===================================
# VARIABLES - Parámetros configurables
# ===================================

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno del proyecto (learning, production, staging)"
  type        = string
  default     = "learning"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "aws-iac-ejercicio"
}

variable "my_ip" {
  description = "Tu dirección IP pública para acceso SSH. Inyectar via variable de entorno: export TF_VAR_my_ip='tu-ip/32'"
  type        = string
  sensitive   = true  # No mostrar en plan/apply
  default     = "0.0.0.0/0"  # Por defecto abierto a todo
}

# Variables de red
variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block para la subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

# Tags comunes para todos los recursos
variable "common_tags" {
  description = "Tags que se aplican a todos los recursos"
  type        = map(string)
  default = {
    CreatedBy   = "Terraform"
    Environment = "learning"
    Project     = "aws-iac-05"
  }
}

 variable "public_key_path" {
  description = "Ruta a tu public key SSH generada con: ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform-aws-key"
  type        = string
  default     = "~/.ssh/terraform-aws-key.pub"
}