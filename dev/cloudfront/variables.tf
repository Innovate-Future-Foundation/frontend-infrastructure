variable "domain_name" {
  type        = string
  description = "Domain name for the CloudFront distribution"
}

variable "bucket_domain_name" {
  type        = string
  description = "Domain name of the S3 bucket"
}

variable "bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate"
}