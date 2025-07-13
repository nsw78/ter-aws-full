variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH já criada na AWS"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nome único do bucket S3"
  type        = string
}

# ✅ Adicionadas agora:

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets para EC2 ou Auto Scaling"
  type        = list(string)
}

variable "iam_instance_profile_name" {
  description = "Nome do IAM Instance Profile associado à EC2"
  type        = string
}

variable "docker_image" {
  description = "Imagem Docker da API para rodar na EC2"
  type        = string
}

variable "min_size" {
  description = "Tamanho mínimo do Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Tamanho máximo do Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Capacidade desejada do Auto Scaling Group"
  type        = number
}

variable "grafana_admin_password" {
  description = "Senha do usuário admin do Grafana"
  type        = string
  sensitive   = true
}