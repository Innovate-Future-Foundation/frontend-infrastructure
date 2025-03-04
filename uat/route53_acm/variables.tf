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

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "create_route53_records" {
  description = "Whether to create Route 53 records"
  type        = bool
  default     = true
}