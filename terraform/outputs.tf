output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = module.vpc.public_subnet_cidr
}

output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = module.vpc.private_subnet_cidr
}

output "nat_gateway_ip" {
  description = "The Elastic IP of the NAT Gateway"
  value       = module.vpc.nat_gateway_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_endpoint
}

output "rds_secret_arn" {
  description = "ARN of the RDS credentials secret"
  value       = module.rds.secret_arn
} 