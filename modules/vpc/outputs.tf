# Exporta o ID da VPC como saída
output "vpc_id" {
  value = aws_vpc.MyVPC.id
}