output "bucket_name" {
  value = aws_s3_bucket.site.id 
  description = "S3 Bucket Name for Site"
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
  description = "CloudFront Domain to Access Site"
}

