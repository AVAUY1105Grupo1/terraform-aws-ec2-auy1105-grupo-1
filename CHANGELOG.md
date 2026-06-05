# Changelog

Todos los cambios notables de este módulo de cómputo serán documentados en este archivo utilizando la convención [Semantic Versioning](https://semver.org/lang/es/).

## [1.0.0] - 2026-06-04
### Añadido
- Módulo de cómputo completamente funcional.
- Implementación de recurso `tls_private_key` y `local_file` para la generación y gestión segura de la llave `.pem` local.
- Uso de `data.aws_ami` para la obtención dinámica de la imagen de Ubuntu 24.04.
- Integración de bloque `provisioner "remote-exec"` para la instalación automatizada de Apache2 y despliegue de landing page HTML personalizada.
- Parametrización completa del módulo a través de `variables.tf`.
- Estructura de pruebas incorporada en la carpeta `examples/`.
