module "mys3" {
        source = "././modules/s3bucket"
        bucket_name = var.bucket_name
        aws_region = var.aws_region
        data_classification = var.data_classification
}
module "myobject" {
        source = "././modules/s3object"
        bucket_name = var.bucket_name
        storage_class = var.storage_class
        data_classification = var.data_classification
}