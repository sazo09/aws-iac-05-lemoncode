# ====================================
# Security Group - Reglas de acceso
# ====================================
# Security Group (NO está incluido en el módulo VPC, así que lo creamos aparte)
resource "aws_security_group" "mi_sg" {
  name        = local.security_group_name
  description = "Permitir trafico HTTP y SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP desde cualquier IP"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH desde tu IP"
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Permitir todo el trafico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.security_group_name
    }
  )
}