# AWS IAC - Terraform Exercise

## 📋 Descripción
Proyecto educativo de Terraform que provisiona una infraestructura completa en AWS incluyendo:
- VPC con subnet pública
- Internet Gateway y enrutamiento
- Security Groups (HTTP y SSH)
- EC2 instance con Docker
- NGINX container en Docker

---

## 🚀 Pre-requisitos

### 1. **Generar SSH Key** (MUY IMPORTANTE)
Cada usuario debe generar su propia SSH key antes de ejecutar Terraform:

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/terraform-aws-key -N ""
```

Esto crea:
- `~/.ssh/terraform-aws-key` (private key - NUNCA compartir)
- `~/.ssh/terraform-aws-key.pub` (public key - importada a AWS)

### 2. **Configurar AWS CLI** (Credenciales)

Las credenciales de AWS se deben configurar **UNA SOLA VEZ** en tu máquina:

```bash
aws configure
```

**Te pedirá:**
- `AWS Access Key ID` → Pega tu Access Key (de AWS Console)
- `AWS Secret Access Key` → Pega tu Secret Key (de AWS Console)
- `Default region name` → `us-east-1`
- `Default output format` → `json`

**¿Dónde se guardan?**
- Se almacenan en `~/.aws/credentials` (NUNCA se versionará)
- Este archivo está en `.gitignore` por seguridad

**Verificar que funciona:**
```bash
aws sts get-caller-identity
# Debería mostrar tu AWS Account ID
```

### 3. **Inyectar tu IP pública** (Variable de entorno)

En lugar de hardcodear tu IP en `terraform.tfvars`, úsala como variable de entorno:

```bash
# Obtener tu IP y pasarla a Terraform
export TF_VAR_my_ip="$(curl -s https://api.ipify.org)/32"

# Verificar que se captó correctamente
echo $TF_VAR_my_ip
```

**¿Por qué así?**
- ✅ No hardcodea credenciales en archivos
- ✅ Sigue best practices del profesor
- ✅ Variable de entorno se aplica automáticamente
- ✅ Más seguro para producción

**Alternativa (si prefieres editar manualmente):**

Edita `terraform.tfvars`:
```hcl
my_ip = "TU_IP_PUBLICA/32"  # Ej: "203.45.123.456/32"
```

⚠️ **Obtener tu IP:**
```bash
curl https://api.ipify.org
# Salida: 203.45.123.456
```

---

## 📝 Configuración

### Step 1: Obtener credenciales de AWS

1. Ve a [AWS Console](https://console.aws.amazon.com)
2. Accede a IAM → Users → Tu usuario
3. Genera un "Access Key" y copia:
   - Access Key ID
   - Secret Access Key

### Step 2: Configurar en tu máquina

```bash
aws configure
```

### Step 3: Configurar variables de Terraform

Los valores por defecto en `terraform.tfvars` funcionan para aprendizaje:

```hcl
aws_region         = "us-east-1"
project_name       = "aws-iac-05-lemoncode"
environment        = "learning"
# my_ip se inyecta via TF_VAR_my_ip (ver arriba)
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
```

**Si quieres cambiar valores:**
- Edita `terraform.tfvars`
- O usa flags: `terraform plan -var="aws_region=eu-west-1"`

---

## 🛠️ Uso

### **Inicializar Terraform**
```bash
terraform init
```

### **Revisar cambios**
```bash
terraform plan
```

### **Crear infraestructura**
```bash
terraform apply
```

### **Ver outputs** (IP pública de la instancia)
```bash
terraform output
```

### **Destruir infraestructura**
```bash
terraform destroy
```

---

## 🔗 Conectar a la instancia

```bash
# Conectar via SSH
ssh -i ~/.ssh/terraform-aws-key ubuntu@<PUBLIC_IP>

# Verificar Docker
docker --version

# Desplegar NGINX
docker run -d -p 80:80 --name nginx nginx

# Verificar NGINX
curl http://<PUBLIC_IP>
```

---

## ⚠️ Notas Importantes

1. **SSH Key**: Cada usuario debe generar la suya - NO compartir private keys
2. **IP de acceso**: Actualizar `my_ip` en `terraform.tfvars` con tu IP pública
3. **Free Tier**: Este proyecto usa `t2.micro` (free tier eligible)
4. **Costos**: Destruir recursos cuando no se usen: `terraform destroy`
5. **State**: El archivo `terraform.tfstate` está en `.gitignore` (no versionar)

---

## 📚 Estructura de archivos

- `provider.tf` - Configuración de AWS
- `variables.tf` - Declaración de variables
- `terraform.tfvars` - Valores específicos (cambiar por usuario)
- `locals.tf` - Variables locales calculadas
- `network.tf` - Recursos de red (VPC, subnet, IGW, route table, SG)
- `keypair.tf` - SSH key pair
- `outputs.tf` - Outputs (IP pública, etc)
- `README.md` - Este archivo

---

## 🔍 Debugging

```bash
# Ver variables
terraform console

# Ver estado actual
terraform show

# Logs detallados
TF_LOG=DEBUG terraform plan
```

---

**Autor**: Terraform Learning Exercise  
**Última actualización**: 2026-04-28

SSH conection
![alt text](image.png)


instance created
![alt text](image-1.png)

Docker version
![alt text](image-2.png)