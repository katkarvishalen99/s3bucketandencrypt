resource "aws_s3_object" "myobject" {
        bucket = var.bucket_name
        key = var.data_classification
        storage_class = var.storage_class
        source = "/home/ec2-user/terraform-project/s3/modules/s3object/hello.txt"
        kms_key_id = var.data_classification == "C3" || var.data_classification == "C4" ? aws_kms_key.mykey.arn : null
        server_side_encryption = var.data_classification == "C3" || var.data_classification == "C4" ? "aws:kms" : "AES256"
}
resource "aws_kms_key" "mykey" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}
