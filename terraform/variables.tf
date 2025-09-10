variable "project_name" {
  description = "Name prefix for resources"
  type = string
  default = "static-website-s3-cf"
}

variable "aws_region" {
  description = "AWS Region for S3 and API Calls"
  type = string
  default = "us-west-1"
}

variable "website_index" {
  description = "Default Index File"
  type = string
  default = "index.html"
}

variable "website_error" {
  description = "Default Error File"
  type = string
  default = "error.html"
}

variable "default_ttl" {
  description = "Default TTL for CloudFront Objects"
  type = number
  default = 3600
}

variable "price_class" {
  description = "CloudFront Price Class"
  type = string
  default = "PriceClass_100"
}



