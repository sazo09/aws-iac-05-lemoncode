resource "aws_key_pair" "ejercicio"{
   key_name   = "${local.name_prefix}-key"
   public_key = file(var.public_key_path)
 
   tags = local.common_tags
}