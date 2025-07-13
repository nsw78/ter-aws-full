variable "name_prefix" {
  description = "Prefixo para nomear os recursos"
  type        = string
}

variable "ami_id" {
  description = "AMI ID da instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Chave SSH para acesso à instância"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o SG será criado"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de Subnet IDs para o Auto Scaling"
  type        = list(string)
}

variable "min_size" {
  description = "Tamanho mínimo do Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Tamanho máximo do Auto Scaling Group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Capacidade desejada do Auto Scaling Group"
  type        = number
  default     = 1
}

variable "target_group_arns" {
  description = "Lista de ARNs do Target Group para o ALB"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile_name" {
  description = "Nome do IAM Instance Profile"
  type        = string
}

variable "docker_image" {
  description = "Imagem Docker da API a ser executada"
  type        = string
}