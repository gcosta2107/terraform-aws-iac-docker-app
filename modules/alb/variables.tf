variable "Aluno" {
  type    = string
  default = "fvm-albgm"
}

variable "Periodo" {
  type    = string
  default = "8"
}

variable "vpc_id" {
  type = string
}

variable "alb_sg" {
  type = string
}

variable "subnet_public_ids" {
  description = "Lista de subnets públicas para o ALB"
  type        = list(string)
}
