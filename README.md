# Módulo de Terraform para Cómputo AWS (EC2)

## Objetivos del repositorio
El objetivo de este repositorio es proporcionar un componente de infraestructura modular enfocado en la gestión de recursos de cómputo en AWS. Permite el despliegue estandarizado de máquinas virtuales (Ubuntu 24.04), automatizando la generación de credenciales de acceso seguras y la configuración inicial del sistema operativo.

## Propósito general del código Terraform
Este código automatiza el ciclo de vida completo de una instancia de cómputo y sus accesos. Sus funciones principales son:
* Generación automática de un par de llaves criptográficas (RSA) y su registro en AWS (`aws_key_pair`).
* Guardado automático de la llave privada localmente en formato `.pem` con permisos seguros.
* Búsqueda dinámica de la última AMI oficial de Ubuntu 24.04.
* Despliegue de la instancia EC2.
* Ejecución remota (`remote-exec` por SSH) para actualizar paquetes, instalar el servidor web Apache2 y montar un archivo HTML personalizado de prueba (VampireNightXX).

## Instrucciones básicas de uso

### Requisitos previos
* Terraform instalado (versión `>= 1.0.0`).
* ID de una subred pública y un Security Group funcional (proporcionados por un módulo de redes). **Nota:** La subred debe asignar IPs públicas para que el provisioner `remote-exec` pueda conectarse por SSH.

### Ejemplo de invocación
Para utilizar este módulo en tu entorno principal, añade el siguiente bloque a tu archivo `main.tf`:

```hcl
module "computo" {
  source = "[github.com/AVAUY1105Grupo1/terraform-aws-ec2-auy1105-grupo-1?ref=v1.0.0](https://github.com/AVAUY1105Grupo1/terraform-aws-ec2-auy1105-grupo-1?ref=v1.0.0)"

  ec2_instance_name      = "servidor-web-prod"
  ec2_instance_type      = "t3.medium"
  ssh_key_name           = "llave-prod-key"
  ssh_key_filename       = "llave-prod-key.pem"
  subnet_id              = "subnet-xxxxxx" # Reemplazar con ID real
  vpc_security_group_ids = ["sg-xxxxxx"]   # Reemplazar con ID real
}
``` 
## Variables de Entrada (Inputs)
Este módulo es altamente personalizable gracias a las siguientes variables:

* ssh_key_name (string): Nombre identificador para registrar el par de llaves en AWS.

* ssh_key_filename (string): Ruta y nombre del archivo físico .pem de la clave privada local.

* tls_key_bits (number): Tamaño criptográfico en bits para la generación de la llave RSA.

* ec2_instance_name (string): Nombre asignado como Tag (Name) identificador de la instancia.

* ec2_instance_type (string): Tipo o tamaño de hardware de la instancia EC2 (ej. t3.medium).

* ami_owner / ami_name_filter (list): Filtros para localizar la AMI deseada (por defecto Ubuntu 24.04).

* ssh_connect_user (string): Usuario por defecto del SO para la sesión SSH (ubuntu).

* subnet_id (string): ID de la subred donde nacerá la interfaz de red de la instancia.

* vpc_security_group_ids (list): Lista de IDs de Security Groups asignados a la instancia.

## Variables de Salida (Outputs)
(Asegúrate de crear un archivo outputs.tf en este repositorio con lo siguiente para cumplir la rúbrica):

* instance_id: El ID de la instancia creada (aws_instance.app.id).

* public_ip: La IP pública asignada a la instancia (aws_instance.app.public_ip).
