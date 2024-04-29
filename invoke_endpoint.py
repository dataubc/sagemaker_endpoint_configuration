import boto3
import numpy as np
import pandas as pd
 
def invoke_endpoint(endpoint_name, input_data):
    runtime_client = boto3.client("runtime.sagemaker")
    response = runtime_client.invoke_endpoint(EndpointName=endpoint_name,
                                              ContentType='text/csv',
                                              Body=input_data.to_csv(header=False, index=False))
    result = response['Body'].read().decode('utf-8')
    return result
   
if __name__ == "__main__":
    endpoint_name = "endpoint_name" # change here
    point_X = np.array([[5.3, 3.7, 1.6],
                        [4.8, 3.0, 0.5],
                        [5.9, 3.0, 5.1]])
    result = invoke_endpoint(endpoint_name, pd.DataFrame(point_X))
    print("Prediction results:", result)