# ===================================
# OUTPUTS - Valores que muestra Terraform
# ===================================
# Estos valores se muestran después de terraform apply
# Útiles para obtener IDs, IPs, nombres de recursos creados

# VPC Outputs
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.main.cidr_block
}

# Internet Gateway Outputs
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Subnet Outputs
output "public_subnet_id" {
  description = "ID de la subnet pública"
  value       = aws_subnet.public_subnet.id
}

output "public_subnet_cidr" {
  description = "CIDR block de la subnet pública"
  value       = aws_subnet.public_subnet.cidr_block
}

# Route Table Outputs
output "route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public_rt.id
}

# Security Group Outputs
output "security_group_id" {
  description = "ID del Security Group"
  value       = aws_security_group.mi_sg.id
}

output "security_group_name" {
  description = "Nombre del Security Group"
  value       = aws_security_group.mi_sg.name
}

# Información útil
output "aws_region" {
  description = "Región de AWS donde se desplegaron los recursos"
  value       = var.aws_region
}

output "environment" {
  description = "Entorno del proyecto"
  value       = var.environment
}

# Resumen de reglas de acceso
output "access_rules_summary" {
  description = "Resumen de las reglas de acceso configuradas"
  value = {
    http_access = "Puerto 80: Accesible desde cualquier IP (0.0.0.0/0)"
    ssh_access  = "Puerto 22: Accesible desde ${var.my_ip}"
  }
  sensitive = true  # ← Contiene my_ip que es sensible
}

output "key_pair_name"{
  description = "Nombre del key pair creado"
  value       = aws_key_pair.ejercicio.key_name
}

# EC2 Instance Outputs
output "instance_public_ip" {
  description = "IP pública de la instancia EC2 - NECESARIA para SSH"
  value       = aws_instance.main.public_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia (alternativa a IP)"
  value       = aws_instance.main.public_dns
}

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.main.id
}

output "ssh_connection_command" {
  description = "Comando para conectarse por SSH a la instancia (usuario: ec2-user para Amazon Linux)"
  value       = "ssh -i ~/.ssh/terraform-aws-key ec2-user@${aws_instance.main.public_ip}"
}