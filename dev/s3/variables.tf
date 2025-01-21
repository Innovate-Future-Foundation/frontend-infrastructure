variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for frontend static files"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "cloudfront_oai_arn" {
  type        = string
  description = "CloudFront Origin Access Identity ARN"
}