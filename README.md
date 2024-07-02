# Proyecto despliegue con Terraform

Analizar la forma más conveniente de despliegue de una VM sobre el RHEV 4.3

## Ajustar ambiente sobre VM local desde donde que aplicarán los cambios

* [Instalar terraform, usando método 2](https://computingforgeeks.com/how-to-install-terraform-on-fedora/)

## Para identificar el cluster id correcto, verificar con la siguiente instrucción
```
curl -u 'usuario:password' -k "https://aluna.mecon.ar/ovirt-engine/api/clusters" | more
```

## Pasos para poder utilizar la solución desde maquina local

* Clonar la solución en la rama MAIN
```
git clone <URL-REPO-MAIN>
```

## Ingresar al directorio clonado y verificar la configuración para el despliegue de la nueva VM.
## Ejecutar los comandos:

* Inicializar Terraform
```
terraform init
```
* Verificar la configuración
```
terraform plan
```
* Aplicar la configuración: hay que confirmar la operación
```
terraform apply
```
* Destruir el plan aplicado anteriormente: hay que confirmar la operación
```
terraform destroy
```