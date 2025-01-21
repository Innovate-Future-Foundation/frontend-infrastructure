variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-2"  
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "domain_name" {
  type        = string
  description = "Domain name for the frontend application"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for frontend static files"
}