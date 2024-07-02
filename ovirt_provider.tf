#Config provider

terraform {
  required_providers {
    ovirt = {
      source  = "ovirt/ovirt"
    }
  }
}

variable "ovirt_password" {}
# Crear archivo llamado terraform.tfvars y agregar la variable para la contraseña:
# ovirt_password = "contraseña_válida" (usar comillas dobles)

provider "ovirt" {
  url             = var.api_url
  username        = var.ovirt_username
  password        = var.ovirt_password       
  tls_ca_files    = ["/etc/pki/ovirt-engine/ca.pem"] 
}

variable "api_url" {
  description = "OVIRT API URL"
  type = string
  default = "https://aluna.mecon.ar/ovirt-engine/api"
}

variable "ovirt_username" {
  description = "OVIRT USERNAME"
  type = string
  default = "vmautocreate@internal"
}