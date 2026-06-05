# Ejemplos de uso del Módulo de Cómputo

## Objetivo del ejemplo
Esta carpeta provee una guía práctica para instanciar de forma aislada el módulo de cómputo. Demuestra cómo inyectar las variables de red (Subnets y Security Groups) necesarias para levantar el servidor y cómo el módulo genera automáticamente el archivo `.pem` en tu entorno de trabajo.

## Instrucciones de ejecución
1. Ingresa a la carpeta del ejemplo:
   ```bash
   cd examples/despliegue_instancia
2. Ejecuta los comandos habituales:
```
terraform init
```
```
terraform plan
```
```
terraform apply
```
(Nota: Al destruir la infraestructura con terraform destroy, recuerda eliminar manualmente el archivo .pem generado localmente si ya no lo necesitas).
