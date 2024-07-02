# variables.tf

# VM data
variable "vm_name" {
  description   = "Virtual machine name"
  type          = string
  default       = "vm-dmacia"
}

# Template id: dpi-rhel9-cis-L1
variable "vm_template_id" {
  description   = "Template id"
  type          = string
  default       = "14cec1ef-81e5-4b30-85da-487288c6c65e"
}

variable "cluster_name" {
  description = "Nombre del clúster donde desplegar la VM"
  type        = string
  default     = "Broadwell"
}

# Setting hostname
variable "vm_hostname" {
  description   = "Setting hostname"
  type          = string
  default       = "vm-hulk"
}

# Setting timezone
variable "vm_timezone" {
  description   = "Setting timezone"
  type          = string
  default       = "America/Argentina/Buenos_Aires"
}

###### Network config
variable "nic_name" {
  description   = "NIC system name"
  type          = string
  default       = "System eth0"
}

# Especificar IP correcta para la VM
variable "ip_address" {
  description   = "IP address for the VM"
  type          = string
  default       = "172.27.10.51" 
}

# Especificar la máscara correcta para la IP dada
variable "cidr" {
  description   = "Netmask for the VM"
  type          = string
  default       = "23"
}

# Especificar la puerta de enlace correcta para la IP dada
variable "gateway" {
  description   = "Default gateway for the VM"
  type          = string
  default       = "172.27.10.2"
}

# DNS productivos de la DGSIAF
variable "dns_servers" {
  description   = "DNS server"
  type          = string
  default       = "172.20.8.50 172.20.13.15"
}

###### Custom CORES requirements ######
# Ajustar  las cantidad de CPU y Sockets de acuerdo  a la necesidad del requirimiento.
# Tener en cuenta que la cantidad de procesadores final estará dado por la formula: 
# PROCESADORES = CORES * SOCKETS * THREADS

variable "add_cpu_cores" {
  description = "The number of CPU cores for the VM."
  type        = number
  default     = 2
}

variable "add_cpu_sockets" {
  description = "The number of CPU sockets for the VM."
  type        = number
  default     = 2
}

#Este parámetro es requerido y se sugiere no cambiarlo
variable "add_cpu_threads" {
  description = "The number of cpu threadss for the VM."
  type        = number
  default     = 1
}
