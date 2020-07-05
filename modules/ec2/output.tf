/*
output "instance-1" {
  value = aws_instance.web-instance.0.id
}

output "instance-2" {
  value = aws_instance.web-instance.1.id
}

output "web_instance" {
  value = aws_instance.web-instance.*.id
}
*/
  
output "web_instance-1" {
  value = aws_instance.web-instance1.id
}

output "web_instance-2" {
  value = aws_instance.web-instance2.id
}
