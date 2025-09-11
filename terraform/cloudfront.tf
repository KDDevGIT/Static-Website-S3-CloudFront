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
}

