# For S3 Bucket
resource "aws_s3_bucket" "site" {
  bucket = local.bucket_name
  force_destroy = true
  tags = {
    Project = var.project_name
  }
}

resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id 
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id 
  block_public_acls = true
  block_public_policy = true 
  ignore_public_acls = true 
  restrict_public_buckets = true 
}

# Local files
locals {
  site_path = "${path.module}/../site"
}

data "local_file" "index" {
  filename = "${local.site_path}/${var.website_index}"
}

data "local_file" "error" {
  filename = "${local.site_path}/${var.website_error}"
}

