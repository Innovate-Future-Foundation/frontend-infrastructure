locals {
  caching_disabled_policy              = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  all_viewer_excpet_host_header_policy = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
}

data "aws_cloudfront_cache_policy" "optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_response_headers_policy" "security_headers" {
  name = "Managed-SecurityHeadersPolicy"
}

resource "aws_cloudfront_origin_access_control" "frontend" {
  name                              = "${var.domain_name}-oac"
  description                       = "Origin Access Control for frontend static website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "frontend" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_All"

  origin {
    domain_name              = var.bucket_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
  }

  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    target_origin_id           = local.s3_origin_id
    viewer_protocol_policy     = "redirect-to-https"
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers.id
    cache_policy_id            = data.aws_cloudfront_cache_policy.optimized.id
    compress                   = true
  }

  # Define the origin for the API Gateway
  origin {
    domain_name = "${var.agw_id}.execute-api.${var.agw_region}.amazonaws.com"
    origin_id   = "apigw-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # Add cache behavior for the `/api/*` path
  ordered_cache_behavior {
    path_pattern     = "/api/*"
    target_origin_id = "apigw-origin"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id          = local.caching_disabled_policy
    origin_request_policy_id = local.all_viewer_excpet_host_header_policy

    compress = true
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = var.domain_aliases

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/"
  }

  tags = merge(
    var.tags,
    {
      Name    = "${var.domain_name}-distribution"
      Service = "Content Delivery"
    }
  )
}

locals {
  s3_origin_id = "S3-${var.domain_name}"
}
