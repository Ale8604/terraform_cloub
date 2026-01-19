virginia_cidr = "10.10.0.0/16"

/* subnet_public = "10.10.0.0/24"

subnet_private = "10.10.1.0/24" */

cidr_subnet = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "Dev"
  "Owner"       = "Alejandro"
  "Cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_VERSION" = "1.14.3"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-068c0051b15cdb816"
  "instance_type" = "t3.micro"
}

enable_monitoring = false

port = [ 22, 80, 443 ]