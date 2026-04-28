resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = local.vpc_name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = local.igw_name
    }
  )
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"  # Usar AZ que soporta t3.micro
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = local.subnet_name
    }
  )
}

# Tabla de rutas pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.route_table_name
    }
  )
}

# Asociar la tabla con la subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


###Security Group para permitir trafico HTTP y SSH
resource "aws_security_group" "mi_sg" {
  name        = local.security_group_name
  description = "Permitir trafico HTTP y SSH"
  vpc_id      = aws_vpc.main.id

  # Regla para HTTP (Puerto 80) desde cualquier IP
  ingress {
    description = "HTTP desde cualquier IP"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla para SSH (Puerto 22) - Solo desde tu IP
  ingress {
    description = "SSH desde tu IP"
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Regla de salida (Egress) - Permitir todo el trafico
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