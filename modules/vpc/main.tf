resource "aws_vpc" "MyVPC" {
  cidr_block = "172.31.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-gcs-dcmr"
    Aluno = var.Aluno
    Periodo = var.Periodo
  }
}