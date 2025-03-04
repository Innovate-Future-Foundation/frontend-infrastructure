data "aws_route53_zone" "domain" {
  count        = var.create_route53_records ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

resource "aws_acm_certificate" "frontend" {
  provider          = aws.us-east-1
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = merge(
    var.tags,
    {
      Name    = "${var.domain_name}-certificate"
      Service = "SSL Certificate"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  domain_validation_options = var.create_route53_records ? aws_acm_certificate.frontend.domain_validation_options : []
}

resource "aws_route53_record" "acm_validation" {
  count   = var.create_route53_records ? length(local.domain_validation_options) : 0
  zone_id = data.aws_route53_zone.domain[0].zone_id
  name    = element(local.domain_validation_options, count.index).resource_record_name
  type    = element(local.domain_validation_options, count.index).resource_record_type
  records = [element(local.domain_validation_options, count.index).resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "frontend" {
  count                   = var.create_route53_records ? 1 : 0
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.frontend.arn
  validation_record_fqdns = var.create_route53_records ? aws_route53_record.acm_validation[*].fqdn : []
}

resource "aws_route53_record" "frontend" {
  count   = var.create_route53_records ? 1 : 0
  zone_id = data.aws_route53_zone.domain[0].zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}