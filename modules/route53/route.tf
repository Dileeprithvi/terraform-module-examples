data "aws_route53_zone" "dileep_domain" {
  name         = "dileeprithvi.tk"
  private_zone = false
}

resource "aws_route53_record" "dileep_cname_record" {
  zone_id = "${data.aws_route53_zone.dileep_domain.zone_id}"
  name    = "www"
  type    = "CNAME"
  ttl     = "300"
  records = ["http://dileeprithvi.tk/"]
  
  }
  
resource "aws_route53_record" "dileep_alias_record" {
  zone_id = "${data.aws_route53_zone.dileep_domain.zone_id}"
  type    = "A"
  name    = ""
  alias {
    name                   = var.mod_alb_dns_name
    zone_id                = var.mod_alb_zone_id
    evaluate_target_health = false
  }  
}
