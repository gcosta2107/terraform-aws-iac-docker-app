variable "Aluno" {
  type = string
}

variable "Periodo" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_private_ids" {
  type = list(string)
}

variable "sg_public_ec2_id" {
  type = string
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