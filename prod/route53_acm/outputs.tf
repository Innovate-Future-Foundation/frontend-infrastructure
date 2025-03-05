output "certificate_arn" {
  value = aws_acm_certificate.frontend.arn
}

output "domain_zone_id" {
  value = data.aws_route53_zone.domain.zone_id
}