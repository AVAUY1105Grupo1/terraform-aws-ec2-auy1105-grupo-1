# Configuración práctica del entorno de pruebas para validar el módulo de cómputo

provider "aws" {
  region = "us-east-1"
}

module "computo_prueba" {
  source = "../../" # Referencia al código local ubicado en la raíz del repositorio

  # Variables descriptivas
  ec2_instance_name      = "servidor-ejemplo-test"
  ec2_instance_type      = "t3.medium"
  
  # Gestión de llaves
  ssh_key_name           = "test-key-aws"
  ssh_key_filename       = "test-key-aws.pem"
  
  # IDs ficticios (Deben reemplazarse por IDs reales en un despliegue genuino)
  subnet_id              = "subnet-12345678" 
  vpc_security_group_ids = ["sg-87654321"]  
}

# (Recuerda definir estos outputs en tu archivo outputs.tf en la raíz del módulo)
output "id_instancia_creada" {
  value = module.computo_prueba.instance_id
}

output "ip_publica_instancia" {
  value = module.computo_prueba.public_ip
}
