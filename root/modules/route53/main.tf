resource "aws_route53_zone" "private_zone" {
  name = var.zone_name

  vpc {
    vpc_id = var.vpc_id
  }

  comment = "Private hosted zone for ${var.zone_name}"
}

resource "aws_route53_record" "instance_record" {
  for_each = var.instances

  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "${each.key}.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [each.value]
}
#health check
resource "aws_route53_record" "instance_record" {
  for_each = var.instances

  zone_id = aws_route53_zone.public_zone.zone_id
  name    = "${each.key}.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [each.value]
  health_check_id = aws_route53_health_check.instance_hc[each.key].id
}
