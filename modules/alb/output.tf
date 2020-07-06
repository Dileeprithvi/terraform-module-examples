output "alb_dns_name" {
  value = aws_alb.alb-internet.dns_name
}


output "alb_zone_id" {
  value = aws_alb.alb-internet.zone_id
}

output "alb_name" {
  value = aws_alb.alb-internet.name
}

output "alb_target_develop" {
  value = [aws_alb_target_group.alb-web-target-group-1.arn]
}

output "alb_target_testing" {
  value = [aws_alb_target_group.alb-web-target-group-2.arn]
}
