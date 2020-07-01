output "instance-1" {
  value = aws_instance.web-instance.0.id
}

output "instance-2" {
  value = aws_instance.web-instance.1.id
}
