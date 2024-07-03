output "s3_arn" {
        value = aws_s3_bucket.mys3.arn
        description = "id of S3"
}