// La vpc que conecta con (us-east-1)
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "cidr_virginia"
  }
}

// la sub red publica
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.cidr_subnet[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Subnet_public_temp"
  }
}

// La Sub red privada
resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.cidr_subnet[1]
  tags = {
    "Name" = "Subnet_private_temp"
  }
  depends_on = [
    aws_subnet.subnet_public
  ]
}

// Internet GetWay
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw_vpc_virginia"
  }
}

// Table de Rutas
resource "aws_route_table" "public_ctr" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_crt"
  }
}


//Asociacion entre la subnet(subnet_public) con la tabla de rutas(public_ctr)
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.public_ctr.id
}

//SEGURITY GROUP (FIREWALL VIRTUAL)
resource "aws_security_group" "sg_segurity_group" {
  name        = "Public instance SG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  // Regla de ingreso al security group
  dynamic "ingress" {
    for_each = var.port
    content {
      description      = "Allow inbound traffic on port ${ingress.value}"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = [var.sg_ingress_cidr]
      ipv6_cidr_blocks = []
    }
  }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_segurity_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

module "s3_bucket" {
  source      = "./modulos/s3"
  name_bucket = "alsot-terraform-bucket-2024"
  
}

output "s3_bucket_name" {
  value = module.s3_bucket.s3_bucket_name
}

module "terraform_state_backend" {
     source = "cloudposse/tfstate-backend/aws"
     # Cloud Posse recommends pinning every module to a specific version
     version     = "1.8.0"
     namespace  = "tfstate-alsot-2024"
     stage      = "prod"
     name       = "terraform"
     attributes = ["state"]
     environment = "us-east-1"

     terraform_backend_config_file_path = "."
     terraform_backend_config_file_name = "backend.tf"
     force_destroy                      = false
   }