variable "instancias" {
  description = "Nombres de las instancias"
  type        = set(string)
  default     = ["apache"]
}

//Instancia creada que interactua con la subnet publica
resource "aws_instance" "public_instance" {
  for_each               = var.instancias
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.subnet_public.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_segurity_group.id]
  user_data              = file("scritps/userdata.sh")
  tags = {
    "Name" = each.value
  }
}

resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring ? 1 : 0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.subnet_public.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_segurity_group.id]
  user_data              = file("scritps/userdata.sh")
  tags = {
    "Name" = "monitoreo"
  }
}





