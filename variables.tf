variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "Aluno" {
  type = string
}

variable "Periodo" {
  type = string
}

variable "key_name" {
  type        = string
  default     = "gcs-dcmr"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type = string
  sensitive = true
  default = "teste123"
}