output "alb_dns_name" {
  value = aws_alb.alb-internet.dns_name
}


output "alb_zone_id" {
  value = aws_alb.alb-internet.zone_id
}
