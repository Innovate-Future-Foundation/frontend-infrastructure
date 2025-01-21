variable "domain_name" {
  type        = string
  description = "Domain name for the frontend application"
}

variable "cloudfront_domain_name" {
  type        = string
  description = "CloudFront distribution domain name"
}

variable "cloudfront_zone_id" {
  type        = string
  description = "CloudFront distribution hosted zone ID"
}