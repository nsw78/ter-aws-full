variable "name_prefix" {
  type        = string
  description = "Prefixo para nomear recursos"
}

variable "policy_arn" {
  type        = string
  description = "ARN da política a ser anexada à role"
}