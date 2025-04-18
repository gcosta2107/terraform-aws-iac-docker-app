provider "aws" {
  region = "ap-northeast-2" # Escolha a região desejada
}

module "vpc" {
  source  = "./modules/vpc"

  Aluno = var.Aluno
  Periodo = var.Periodo
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id = module.vpc.vpc_id

  Aluno = var.Aluno
  Periodo = var.Periodo
}

# Módulo dos Security Groups
module "security_groups" {
  source  = "./modules/security_groups"

  vpc_id  = module.vpc.vpc_id

  Aluno   = var.Aluno
  Periodo = var.Periodo
  
}

# Módulo do ALB
module "alb" {
  source             = "./modules/alb"
  Aluno              = var.Aluno
  Periodo            = var.Periodo
  vpc_id             = module.vpc.vpc_id
  subnet_public_ids  = module.subnet.public_subnet_ids
  alb_sg             = module.security_groups.sg_alb_id
}


module "ec2" {
  source = "./modules/ec2"
  Aluno   = var.Aluno
  Periodo = var.Periodo
  key_name = var.key_name

  sg_public_ec2 = module.security_groups.sg_public_ec2_id
  target_group_arns = module.alb.target_group_arns
  subnet_public_id = module.subnet.public_subnet_id
}

# Módulo do RDS
module "rds" {
  source = "./modules/rds"
  Aluno   = var.Aluno
  Periodo = var.Periodo

  vpc_id  = module.vpc.vpc_id

  subnet_private_ids = module.subnet.subnet_private_ids
  sg_public_ec2_id = module.security_groups.sg_rds_id

  db_username        = var.db_username
  db_password        = var.db_password
}
