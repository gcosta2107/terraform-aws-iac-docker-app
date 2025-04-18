# Criação de Security Groups

# Security Group para instância EC2 pública (porta 80 liberada para 0.0.0.0/0)
resource "aws_security_group" "public_ec2_sg" {
  name        = "public-ec2-sg"
  description = "Security Group for public EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "public-ec2-sg"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}

# Security Group para instância EC2 privada (porta 80 liberada para o Security Group da instância pública)
resource "aws_security_group" "private_ec2_sg" {
  name        = "private-ec2-sg"
  description = "Security Group for private EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "private-ec2-sg"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}

# Security Group para RDS (porta 3306 liberada para o Security Group da instância EC2 privada)
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.private_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "rds-sg"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}

# Security Group para ALB (porta 80 liberada para 0.0.0.0/0)
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "alb-sg"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}