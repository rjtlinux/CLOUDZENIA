terraform {
  backend "s3" {
    bucket = "cloudzenia-terraform-backend"
    key    = "ecs-terraform.tfstate"
    region = "ap-south-1"
  }
} 