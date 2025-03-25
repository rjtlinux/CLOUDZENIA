# Hello Microservice

A lightweight Node.js microservice that returns a "Hello from Microservice" message.

## Prerequisites

- Node.js (v18 or later)
- Docker
- AWS CLI configured with appropriate credentials
- Terraform

## Local Development

1. Install dependencies:
```bash
npm install
```

2. Start the application:
```bash
npm start
```

The service will be available at `http://localhost:3000`

## Docker Local Build and Run

1. Build the Docker image:
```bash
docker build -t hello-microservice .
```

2. Run the container:
```bash
docker run -p 3000:3000 hello-microservice
```

## Deploy to AWS ECR

1. Initialize and apply Terraform configuration:
```bash
terraform init
terraform apply
```

2. Get your AWS Account ID:
```bash
aws sts get-caller-identity --query Account --output text
```

3. Authenticate Docker with ECR (replace placeholders with your values):
```bash
aws ecr get-login-password --region YOUR_AWS_REGION | docker login --username AWS --password-stdin YOUR_AWS_ACCOUNT_ID.dkr.ecr.YOUR_AWS_REGION.amazonaws.com
```

4. Tag and push the image to ECR:
```bash
# Tag the image
docker tag hello-microservice:latest YOUR_AWS_ACCOUNT_ID.dkr.ecr.YOUR_AWS_REGION.amazonaws.com/hello-microservice:latest

# Push to ECR
docker push YOUR_AWS_ACCOUNT_ID.dkr.ecr.YOUR_AWS_REGION.amazonaws.com/hello-microservice:latest
```

## Project Structure

- `app.js` - Main application file
- `package.json` - Project dependencies and scripts
- `Dockerfile` - Container configuration
- `main.tf` - Terraform configuration for AWS resources
- `.gitignore` - Git ignore rules

## API Endpoint

- `GET /` - Returns `{"message": "Hello from Microservice"}`

## Infrastructure

The Terraform configuration creates:
- ECR repository for the Docker image
- S3 backend for storing Terraform state
- Repository lifecycle policies
- Repository access policies

## Notes

- The application uses port 3000 by default
- The ECR repository is configured to scan images on push
- Terraform state is stored in the `cloudzenia-terraform-backend` S3 bucket 