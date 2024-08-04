# Terraform Backend Configuration

This README provides instructions on how to configure the backend for Terraform infrastructure using the appropriate settings.

## Prerequisites

Before configuring the backend, make sure you have the following prerequisites:

- Terraform installed on your local machine
- Access to the AWS where you want to store the Terraform state

## Steps to Configure Backend

1. Open the `variables.tf` file in your Terraform project.
2. Rename the bucket name from `bucket_name` to your bucket name. Please note that bucket name needs to be unique.

## Backend Configuration Options

The backend configuration options may vary depending on the cloud provider you are using. Here are some common options:

- `bucket`: The name of the bucket where the Terraform state will be stored.
- `key`: The name of the state file within the bucket.
- `region`: The region where the bucket will be created.

For detailed instructions on configuring the backend for specific cloud providers, refer to their respective documentation.


## Example configuration

You need to have following configuratino in your `provider.tf` :

```
terraform {

  backend "s3" {
    bucket         = "hello-eks-terraform-states"
    key            = "state/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "hello-eks-terraform-state-lock"
  }  

  required_version = "= 1.9.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61.0"
    }
  }
}
```