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

variable "domain_name" {
  type        = string
  description = "Domain name for the frontend application"
  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.domain_name))
    error_message = "Domain name must be a valid domain name."
  }
}