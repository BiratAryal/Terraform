resource "aws_s3_bucket" "app" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "v" {
  bucket = aws_s3_bucket.app.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.app.id
  rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
}

resource "aws_s3_bucket_lifecycle_configuration" "lc" {
  bucket = aws_s3_bucket.app.id
  rule {
    id     = "transition-ia"
    status = "Enabled"
    transition { days = 30, storage_class = "STANDARD_IA" }
    expiration { days = 365 }
  }
}

resource "aws_s3_bucket_metric" "all" {
  bucket = aws_s3_bucket.app.id
  name   = "AllRequests"
}

resource "aws_s3_bucket" "logs" {
  count  = var.enable_access_logs ? 1 : 0
  bucket = "${var.bucket_name}-access-logs"
  tags   = var.tags
}

resource "aws_s3_bucket_logging" "log" {
  count         = var.enable_access_logs ? 1 : 0
  bucket        = aws_s3_bucket.app.id
  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "s3-access/"
}
