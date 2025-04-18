output "alb_dns_name" {
  value       = aws_lb.application_lb.dns_name
}

output "target_group_arns" {
  value = [aws_lb_target_group.web_tg.arn]
}
