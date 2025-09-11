# Origin Access Control
resource "aws_cloudfront_origin_access_control" "oac" {
  name = "${var.project_name}-oac"
  description = "OAC for ${var.project_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  enabled = true 
  is_ipv6_enabled = true 
  comment = "${var.project_name} static site"
  price_class = var.price_class
  aliases = var.aliases

  origin {
    domain_name = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id = "s3-origin"
    s3_origin_config {
      origin_access_identity = ""
    }

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id 
  }
  default_root_object = var.website_index
  default_cache_behavior {
    target_origin_id = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET","HEAD","OPTIONS"]
    cached_methods = ["GET","HEAD"]
    compress = true 
    forwarded_values {
      query_string = false 
      cookies {
        forward = "none"
      }
    }
    min_ttl = 0
    default_ttl = var.default_ttl
    max_ttl = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  custom_error_response {
    error_code = 404 
    response_code = 200 
    response_page_path = "/${var.website_error}"
    error_caching_min_ttl = 0
  }
  tags = {
    Project = var.project_name
  }
}

resource "aws_s3_bucket_policy" "allow_cf" {
  bucket = aws_s3_bucket.site.id 
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
         {
        Sid      = "AllowCloudFrontServicePrincipalReadOnly",
        Effect   = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = ["s3:GetObject"],
        Resource = [
          "${aws_s3_bucket.site.arn}/*"
        ],
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.this.arn
          }
        }
      }
    ]
  })
  depends_on = [ aws_cloudfront_distribution.this ]
}

