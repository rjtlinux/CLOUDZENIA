# Cloudzenia Terraform Infrastructure

This repository contains Terraform configurations for setting up AWS infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (version >= 1.0.0)
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

## Project Structure

```
.
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable definitions
├── outputs.tf        # Output definitions
├── terraform.tfvars  # Variable values
└── .gitignore       # Git ignore rules
```

## Resources Created

- VPC with DNS support
- Public subnet in the specified availability zone

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the changes:
   ```bash
   terraform apply
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

## Variables

- `aws_region`: AWS region to deploy resources (default: us-west-2)
- `project_name`: Name of the project (default: cloudzenia)
- `vpc_cidr`: CIDR block for VPC (default: 10.0.0.0/16)
- `subnet_cidr`: CIDR block for subnet (default: 10.0.1.0/24)
- `availability_zone`: Availability zone for subnet (default: us-west-2a)

## State Management

The configuration is set up to use S3 as a backend for state management. Before using this configuration:

1. Create an S3 bucket for storing the Terraform state
2. Uncomment and configure the backend settings in `main.tf`
3. Ensure your AWS credentials have access to the S3 bucket

## Security Notes

- Never commit sensitive information or credentials
- Use AWS IAM roles and policies to restrict access
- Review the security group rules before applying