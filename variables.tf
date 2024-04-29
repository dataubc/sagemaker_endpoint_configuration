
variable "s3_bucket_name" {
  description = "The name of the S3 bucket where the XGBoost model is stored"
  type        = string
}

variable "model_path" {
  description = "The S3 path to the XGBoost model artifact"
  type        = string
}
