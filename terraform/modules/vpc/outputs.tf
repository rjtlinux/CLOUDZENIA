output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = aws_subnet.private.cidr_block
}

output "nat_gateway_ip" {
  description = "The Elastic IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.private.id, aws_subnet.private_2.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public.id, aws_subnet.public_2.id]
} 