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

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for frontend static files"
}

variable "domain_name" {
  type        = string
  description = "Domain name for the frontend application"
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.domain_name))
    error_message = "Domain name must be a valid domain name."
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "IFF"
    Owner       = "IFA"
  }
}