output "sg_private_ec2_id" {
  value = aws_security_group.private_ec2_sg.id
}

output "sg_rds_id" {
  value = aws_security_group.rds_sg.id
}

output "sg_alb_id" {
  value = aws_security_group.alb_sg.id
}
output "sg_public_ec2_id" {
  value = aws_security_group.public_ec2_sg.id
}