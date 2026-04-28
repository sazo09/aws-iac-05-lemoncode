# ===================================
# EC2 INSTANCE - Compute Layer
# ===================================

# Data source para obtener la AMI más reciente (Amazon Linux 2023 - Free Tier)
# Usamos AWS SSM Parameter Store (como el profesor)
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Instancia EC2
resource "aws_instance" "main" {
  # AMI y tipo de instancia (FREE TIER)
  ami           = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = local.instance_type_free_tier

  # Networking
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.mi_sg.id]

  # SSH Access
  key_name = aws_key_pair.ejercicio.key_name

  # Asignar IP pública automáticamente
  associate_public_ip_address = true

  # User Data - Instalar Docker automáticamente
  user_data = file("${path.module}/user_data.sh")

  # Tags
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-instance"
    }
  )

  # Esperar a que los recursos de red estén listos
  depends_on = [
    aws_internet_gateway.igw,
    aws_security_group.mi_sg
  ]
}
