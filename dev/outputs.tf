output "s3_bucket" {
  description = "The name of the S3 bucket hosting the static website"
  value       = module.s3.bucket_name
}

output "cloudfront_distribution_url" {
  description = "The domain name of the CloudFront distribution"
  value       = module.cloudfront.distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = module.cloudfront.distribution_id
}

output "website_domain" {
  description = "The domain name of the website"
  value       = var.domain_name
}

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.route53_acm.certificate_arn
}