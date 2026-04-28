# ===================================
# LOCALS - Variables locales calculadas
# ===================================
# Locals son valores que se calculan una sola vez
# Útiles para evitar repetir valores complejos

locals {
  # Nombre consistente para todos los recursos
  name_prefix = "${var.project_name}-${var.environment}"

  # Tags que se aplican a TODOS los recursos
  common_tags = merge(
    var.common_tags,
    {
      ManagedBy   = "Terraform"
      LastUpdated = timestamp()
    }
  )

  # Puertos comunes
  ssh_port  = 22
  http_port = 80

  # Información sobre la VPC
  vpc_name            = "${local.name_prefix}-vpc"
  igw_name            = "${local.name_prefix}-igw"
  subnet_name         = "${local.name_prefix}-subnet-publica"
  route_table_name    = "${local.name_prefix}-rt-publica"
  security_group_name = "${local.name_prefix}-sg"

  # Configuración de instancia (GARANTIZA FREE TIER)
  # t3.micro es free tier eligible en esta cuenta (más moderno que t2.micro)
  instance_type_free_tier = "t3.micro"
}
