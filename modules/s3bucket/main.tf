resource "aws_s3_bucket" "mys3" {
        bucket = var.bucket_name
}
resource "aws_s3_bucket_server_side_encryption_configuration" "mys3encrypt" {
        bucket = aws_s3_bucket.mys3.id

                rule {
                        apply_server_side_encryption_by_default {
                        kms_master_key_id = var.data_classification == "C3" || var.data_classification == "C4" ? aws_kms_key.mykey.arn : null
                        sse_algorithm     = var.data_classification == "C3" || var.data_classification == "C4" ? "aws:kms" : "AES256"
    }
  }
}
resource "aws_kms_key" "mykey" {
        description             = "KMS key 1"
        deletion_window_in_days = 7
}
resource "aws_s3_bucket_acl" "mys3" {
        bucket = aws_s3_bucket.mys3.id
        acl    = "private"
        depends_on = [aws_s3_bucket_ownership_controls.mys3]
}
resource "aws_s3_bucket_versioning" "mys3" {
        bucket = aws_s3_bucket.mys3.id
        versioning_configuration {
                status = "Enabled"
        }
}
resource "aws_s3_bucket_ownership_controls" "mys3" {
        bucket = aws_s3_bucket.mys3.id
        rule {
                object_ownership = "ObjectWriter"
        }
        depends_on = [aws_s3_bucket.mys3]
}
