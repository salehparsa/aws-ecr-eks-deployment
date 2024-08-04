# AWS ECR EKS Deployment

This repository demonstrates a CI/CD pipeline setup for deploying containerized applications to AWS Elastic Kubernetes Service (EKS) using Amazon Elastic Container Registry (ECR). The pipeline utilizes GitHub Actions for automating the build, test, and deployment processes.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [AWS ECR Setup](#aws-ecr-setup)
  - [EKS Cluster Setup](#eks-cluster-setup)
  - [GitHub Actions Configuration](#github-actions-configuration)
- [Project Structure](#project-structure)
- [Deployment Workflow](#deployment-workflow)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

1. **AWS Account**: Required for creating ECR repositories and EKS clusters.
2. **AWS CLI**: Installed and configured with appropriate permissions.
3. **kubectl**: Installed for interacting with the EKS cluster.
4. **Docker**: Installed for building container images.
5. **GitHub Repository**: To store and manage your application code and GitHub Actions workflows.
6. **Terraform** : To deploy the infrastructure from the infrastructure directory, you need to have terraform installed.


## Deploy Infrastructure via Terraform

You just need to navigate into Infrastructure directory and then:

1. First configure and deploy backend directory.
2. From Infrastructure directory deploy the whole infrastructure.

**Note**: This infrastructure use the `terraform-aws-modules/eks/aws` module.

## Manual Setup Instructions

### AWS ECR Setup

1. **Create an ECR Repository**:
   - Navigate to the [ECR console](https://console.aws.amazon.com/ecr).
   - Create a new private repository to store Docker images.
   - Note the repository URI, as it will be used in the GitHub Actions workflow.

2. **Configure IAM Permissions**:
   - Ensure that the user or role executing the pipeline has the necessary permissions to push images to ECR and manage EKS. A policy might include permissions for `ecr:*`, `cloudtrail:LookupEvents`, and `eks:*`.

3. **Create an EKS Cluster**:
   - Use the AWS Management Console or tools like eksctl to create an EKS cluster.
   - Ensure the cluster has necessary resources, such as nodes and networking components.
   - Set up the appropriate IAM roles and permissions for the cluster and its nodes.

### GitHub Actions Configuration

1. **Repository Secrets**:
   - Store the following AWS credentials as GitHub repository secrets:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY`
   - These secrets will be used by the GitHub Actions workflow to authenticate with AWS services.

## Project Structure

- **.github/workflows**: This directory contains the Github action workflow to build container, tag it and push it into ECR from main branch and deploy the container to EKS
- **app**: Simple Flask application to demonstrate hello world.
- **infrastructure**: Contains terraform modules and configuration for building up all resources such as `ECR`, `iam`, `vpc` and `EKS` on AWS.
- **Dockerfile**: Defines the Docker image for the application.
- **.github/workflows/**: Contains GitHub Actions workflows.
- **namespace.yaml**: Kubernetes manifests for create a namespace on `EKS` via Github Action.
- **deployement.yaml**: Deployment manifests for deploying application on `EKS`.
- **service.yaml**: Service manifests for deploying service of the application on `EKS`.


## Deployment Workflow

1. **Build and Push Docker Image**:
   - The workflow builds the Docker image from the source code and pushes it to the `ECR` repository.

2. **Deploy to EKS**:
   - The application is deployed to the EKS cluster using Kubernetes manifests defined in the repository. The deployment can be managed using `kubectl`.

3. **Continuous Deployment**:
   - The GitHub Actions workflow is configured to automatically trigger on code pushes on main branch, enabling continuous deployment.

