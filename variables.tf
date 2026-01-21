variable "virginia_cidr" {
  description = "CIDR virginia"
  type        = string
}

/* variable "subnet_public" {
  description = "CIDR PUBLIC SUBNET"
  type = string
}

variable "subnet_private" {
  description = "CIDR PRIVATE SUBNET"
  type = string
} */

variable "cidr_subnet" {
  description = "cidr subnet"
  type        = list(string)
}

variable "tags" {
  description = "tags de las SUBNET"
  type        = map(string)
}

variable "sg_ingress_cidr" {
  description = "Cidr for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "parametros de la instancia"
  type        = map(string)
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
}

variable "port" {
  description = "port_vpc"
  type = list(number)
}

variable "access_key" {
  description = "access_key"
  type = string
  
}

variable "secret_key" {
  description = "secret_key"
  type = string
}