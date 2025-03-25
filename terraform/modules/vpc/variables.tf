variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
}

variable "public_availability_zone" {
  description = "Availability zone for public subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for second private subnet"
  type        = string
}

variable "private_subnet_2_az" {
  description = "Availability zone for second private subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for second public subnet"
  type        = string
}

variable "public_subnet_2_az" {
  description = "Availability zone for second public subnet"
  type        = string
} 