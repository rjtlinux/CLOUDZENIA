terraform {
  backend "s3" {
    bucket = "cloudzenia-terraform-backend"
    key    = "hello-microservice/terraform.tfstate"
    region = "ap-south-1"  
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "microservice_repo" {
  name                 = "hello-microservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.microservice_repo.repository_url
} 