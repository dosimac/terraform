# Creación de una máquina virtual a partir de una plantilla con hardening
# Se utiliza la plantilla: template-rhel94-CIS-level-1

###### Obtener las listas de clústeres disponibles ######

locals {
  clusters = {
    # Mapa de nombres de clústeres y sus IDs correspondientes
    "Broadwell" = "3dd8ddf0-86a5-4f9e-9e1e-e9da87362e07"
    "broadwell_Externos_nccp_prod" = "30f123b2-68fe-4d91-b1de-923e29825ce7"
    "Broadwell_OKD_NCCP" = "e6045be2-0924-429c-aab2-19d79a6bb73a"
    "Nehalem_OKD_CCR" = "dbc13440-62ae-491b-afe4-6bc4233d4684"
    "SandyBridge" = "93e06299-b4f2-4e76-9548-97e29173af71"
    "Thewall" = "a6aa466d-bf0a-405f-91bd-0f7c27bf6016"
    "Westmereans" = "4a3a2bc5-ffbe-4c1b-8fa8-f7ff5d06875c"
    "Wheels" = "e08bc2cf-f5c2-4ee1-8e4d-a7a3e6374bac"
    # Añadir más clústeres si es necesario
  }
}

# Recurso para crear la máquina virtual
resource "ovirt_vm" "vm-wt" {
  name        = "${var.vm_name}"
  template_id = "${var.vm_template_id}"
  cluster_id  = local.clusters[var.cluster_name]

  ## Custom CPU requirement ##
  cpu_cores   = var.add_cpu_cores
  cpu_sockets = var.add_cpu_sockets
  cpu_threads = var.add_cpu_threads
  ## Custom CPU requirement ##

  # Configuración del nombre de host
  initialization_hostname = "${var.vm_hostname}"

  # Script de inicialización personalizado
  initialization_custom_script = yamlencode({
    "timezone" : "${var.vm_timezone}"

    write_files = [
      {
        content = <<EOF
          #!/bin/bash
          # Configurar la NIC
          NIC_NAME="${var.nic_name}"
          # Configurar IP estática
          IP_ADDRESS="${var.ip_address}"
          CIDR="${var.cidr}"
          GATEWAY="${var.gateway}"
          DNS_SERVERS="${var.dns_servers}"
          # Aplicar configuración de red
          nmcli connection modify "$NIC_NAME" ipv4.method manual ipv4.addresses "$IP_ADDRESS"/"$CIDR" ipv4.gateway "$GATEWAY" ipv4.dns "$DNS_SERVERS"
          nmcli connection up "$NIC_NAME"

          # Escribir la IP en un archivo de texto en /tmp
          echo "$IP_ADDRESS" > /tmp/vm_ip.txt

          # Modificar sudoers para descomentar %wheel ALL=(ALL) NOPASSWD: ALL
          SUDOERS_FILE="/etc/sudoers"
          sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' $SUDOERS_FILE
          EOF
        path = "/tmp/configure-network-sudoers.sh"
      }
    ]
    # Comandos a ejecutar durante la inicialización
    runcmd = [
        ["sh", "-c", "chmod +x /tmp/configure-network-sudoers.sh"],
        ["sh", "-c", "sh /tmp/configure-network-sudoers.sh"]
    ]
  })
}

# Recurso para iniciar la máquina virtual después de su creación
resource "ovirt_vm_start" "start_vm" {
  vm_id = ovirt_vm.vm-wt.id
}



