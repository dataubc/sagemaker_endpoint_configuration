# SageMaker Endpoint Configuration
Using terraform to setup SageMaker Endpoint

Steps:

- Create a model using model_training notebook, store the model in S3 as  `tar.gz file`
- Change the s3_bucket_name in the `main.auto.tfvars` file
- Run `terraform init`, `terraform plan` and `terrafrom apply`
- Change the `endpoint_name` variable in the `invoke_endpoint.py` file
- Run `python endpoint_name.py` to test the endpoint
- Destroy the resources by running `terraform destroy`
