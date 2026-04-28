resource "aws_key_pair" "ejercicio" {
  key_name   = "${local.name_prefix}-key"
  public_key = file(pathexpand(var.public_key_path))  # pathexpand() expande ~

  tags = local.common_tags
}