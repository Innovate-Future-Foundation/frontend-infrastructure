output "distribution_id" {
  value = aws_cloudfront_distribution.frontend.id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.frontend.domain_name
}

output "distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.frontend.hosted_zone_id
}

output "cloudfront_oai_arn" {
  value = aws_cloudfront_origin_access_identity.frontend.iam_arn
}