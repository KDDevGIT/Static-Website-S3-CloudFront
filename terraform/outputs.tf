output "bucket_name" {
  value = aws_s3_bucket.site.id 
  description = "S3 Bucket Name for Site"
}

