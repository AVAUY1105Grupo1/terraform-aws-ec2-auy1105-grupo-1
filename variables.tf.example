variable "ssh_key_name" {
  description = "Nombre identificador para registrar el par de llaves en AWS"
  type        = string
  default     = "VampireNightXX-key"
}

variable "ssh_key_filename" {
  description = "Ruta y nombre del archivo fisico .pem de la clave privada local"
  type        = string
  default     = "VampireNightXX-key.pem"
}

variable "tls_key_bits" {
  description = "Tamano criptografico en bits para la generacion de la llave RSA"
  type        = number
  default     = 4096
}

variable "ec2_instance_name" {
  description = "Nombre asignado como Tag identificador de la instancia de computo"
  type        = string
  default     = "VampireNightXX-ec2"
}

variable "ec2_instance_type" {
  description = "Tipo o tamano de hardware de la instancia EC2 en AWS"
  type        = string
  default     = "t3.medium"
}

variable "ami_owner" {
  description = "ID de la cuenta propietaria o distribuidora oficial de la AMI"
  type        = list(string)
  default     = ["099720109477"]
}

variable "ami_name_filter" {
  description = "Cadena de texto para filtrar y localizar la AMI deseada"
  type        = list(string)
  default     = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
}

variable "ssh_connect_user" {
  description = "Usuario por defecto del SO para establecer la sesion SSH"
  type        = string
  default     = "ubuntu"
}

variable "subnet_id" {
  description = "ID de la subred donde nacera la interfaz de red de la instancia"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de Security Groups asignados a la instancia"
  type        = list(string)
  default     = []
}
