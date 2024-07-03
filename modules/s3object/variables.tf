variable "bucket_name" {
  type = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "Bucket names must be between 3 (min) and 63 (max) characters long"
  }

  validation {
    condition     = can(regex("^[a-z0-9.-]{1,64}$", var.bucket_name))
    error_message = "Bucket names can consist only of lowercase letters, numbers, dots (.), and hyphens (-)."
  }

  validation {
    condition     = can(regex("^[a-z0-9].*[a-z0-9]$", var.bucket_name))
    error_message = "Bucket names must begin and end with a letter or number"
  }

  validation {
    condition     = !strcontains(var.bucket_name, "..")
    error_message = "Bucket names must not contain two adjacent periods."
  }

  validation {
    condition     = !can(regex("^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$", var.bucket_name))
    error_message = "Bucket names must not be formatted as an IP address (for example, 192.168.5.4)"
  }

  validation {
    condition     = !startswith(var.bucket_name, "xn--")
    error_message = "Bucket names must not start with the prefix xn--"
  }

  validation {
    condition     = !startswith(var.bucket_name, "sthree-")
    error_message = "Bucket names must not start with the prefix sthree-"
  }

  validation {
    condition     = !endswith(var.bucket_name, "-s3alias")
    error_message = "Bucket names must not end with the suffix -s3alias."
  }

  validation {
    condition     = !endswith(var.bucket_name, "--ol-s3")
    error_message = "Bucket names must not end with the suffix --ol-s3"
  }
}
variable "data_classification" {
  description = "Data classification values allowd C1 C2 C3 C4"
  type        = string
  
  validation {
    condition     = can(regex("C[1-4]", var.data_classification)) 
    error_message = "Must be valid data classification."
  }
}
variable "storage_class" {
  description = "Specifies the desired Storage Class for the object. Can be either STANDARD, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, DEEP_ARCHIVE"
  type        = string
  validation {
    condition     = contains(["STANDARD", "STANDARD_IA", "ONEZONE_IA", "INTELLIGENT_TIERING", "GLACIER", "DEEP_ARCHIVE"],var.storage_class)
    error_message = "Must be valid storage class."
  }
}