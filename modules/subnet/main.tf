# Subnet Pública 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-subnet-1-gcs-dcmr"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

# Subnet Pública 2 - Nova Subnet
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.4.0/24"
  availability_zone = "ap-northeast-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-subnet-2-gcs-dcmr"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

# Subnets privadas (sem alterações)
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "ap-northeast-2b"

  tags = {
    Name    = "private-subnet-1-gcs-dcmr"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.31.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name    = "private-subnet-2-gcs-dcmr"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

# IGW e rotas continuam iguais
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name    = "main-internet-gateway"
    Aluno   = var.Aluno
    Periodo = var.Periodo
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associação das duas subnets públicas à tabela de rotas públicas
resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}
