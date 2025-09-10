locals {
  bucket_name = "${var.project_name}-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 3
}

