output "certificate_arn" {
  value = aws_acm_certificate.frontend.arn
}

output "domain_zone_id" {
  value = var.create_route53_records ? data.aws_route53_zone.domain[0].zone_id : ""
}