
# SageMaker model using an existing S3 bucket and model path
resource "aws_sagemaker_model" "xgb_model" {
  name = "xgb-model-${var.s3_bucket_name}"

  execution_role_arn = aws_iam_role.sagemaker_role.arn

  primary_container {
    image         = "341280168497.dkr.ecr.ca-central-1.amazonaws.com/sagemaker-xgboost:1.7-1" # SageMaker XGBoost built-in image
    model_data_url = "s3://${var.s3_bucket_name}/${var.model_path}"
    # environment = {
    #   SAGEMAKER_PROGRAM = "custom_inference_code.py" # Specify if using custom inference code
    # }
  }
}

# SageMaker endpoint configuration
resource "aws_sagemaker_endpoint_configuration" "xgb_endpoint_config" {
  name = "xgb-model-endpoint-config-${var.s3_bucket_name}"

  production_variants {
    variant_name          = "AllTraffic"
    model_name            = aws_sagemaker_model.xgb_model.name
    initial_instance_count = 1
    instance_type         = "ml.m4.xlarge"
  }
}

# SageMaker endpoint
resource "aws_sagemaker_endpoint" "xgb_endpoint" {
  name                 = "xgb-model-endpoint-${var.s3_bucket_name}"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.xgb_endpoint_config.name
}
