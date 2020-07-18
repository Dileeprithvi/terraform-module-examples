resource "aws_transfer_server" "main" {

  identity_provider_type = "SERVICE_MANAGED"
  endpoint_type = "PUBLIC"
  tags = {
    Automation = "Terraform"
  }
}

resource "aws_route53_record" "main" {
  name    = var.domain_name
  zone_id = var.zone_id
  type    = "CNAME"
  ttl     = "300"
  records = [
    aws_transfer_server.main.endpoint
  ]
}
resource "null_resource" "associate_custom_hostname" {
  provisioner "local-exec" {
    command = <<EOF
aws transfer tag-resource \
  --arn '${aws_transfer_server.main.arn}' \
  --tags \
    'Key=aws:transfer:customHostname,Value=${aws_route53_record.main.name}' \
    'Key=aws:transfer:route53HostedZoneId,Value=/hostedzone/${aws_route53_record.main.zone_id}'
EOF
  }
  depends_on = ["aws_transfer_server.main", "aws_route53_record.main"]
}
