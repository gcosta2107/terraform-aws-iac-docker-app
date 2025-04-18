resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_private_ids

  tags = {
    Name    = "rds-subnet-group"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}

resource "aws_db_instance" "mysql" {
  identifier         = "mysql-db"
  allocated_storage  = 20
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  username           = var.db_username
  password           = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.sg_public_ec2_id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  backup_retention_period = 7
  port = 3306

  tags = {
    Name    = "mysql-db"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}