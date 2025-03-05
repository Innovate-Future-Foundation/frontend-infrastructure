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

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
  default     = "prod"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
}

variable "agw_id" {
  type        = string
  description = "The backend API Gateway id"
}

variable "agw_region" {
  type        = string
  description = "The backend API Gateway Region"
}