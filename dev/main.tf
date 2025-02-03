locals {
  bucket_name = "${var.environment}-${var.bucket_name}"
}

module "s3" {
  source = "./s3"

  bucket_name                 = local.bucket_name
  environment                 = var.environment
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
  tags                        = var.tags

}

module "cloudfront" {
  source = "./cloudfront"

  domain_name         = var.domain_name
  bucket_domain_name  = module.s3.bucket_domain_name
  bucket_arn          = module.s3.bucket_arn
  acm_certificate_arn = module.route53_acm.certificate_arn
  environment         = var.environment
  tags                = var.tags
}

module "route53_acm" {
  source = "./route53_acm"
  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  domain_name            = var.domain_name
  cloudfront_domain_name = module.cloudfront.distribution_domain_name
  cloudfront_zone_id     = module.cloudfront.distribution_hosted_zone_id
  tags                   = var.tags
}
