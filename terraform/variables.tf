variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "cloudzenia"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "public_availability_zone" {
  description = "Availability zone for public subnet"
  type        = string
  default     = "ap-south-1b"
}

# RDS Variables
variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "wordpress"
}

variable "database_username" {
  description = "Database master username"
  type        = string
  default     = "wordpress"
}

variable "database_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

# Comment out all ECS-related variables
# variable "task_cpu" { ... }
# variable "task_memory" { ... }
# variable "desired_count" { ... }
# variable "min_capacity" { ... }
# variable "max_capacity" { ... }
# variable "cpu_threshold" { ... }
# variable "memory_threshold" { ... }
# variable "db_host" { ... }

# Add these new variables
variable "private_subnet_2_cidr" {
  description = "CIDR block for second private subnet"
  type        = string
  default     = "10.0.3.0/24"  # Different CIDR from other subnets
}

variable "private_subnet_2_az" {
  description = "Availability zone for second private subnet"
  type        = string
  default     = "ap-south-1b"  # Different AZ
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for second public subnet"
  type        = string
  default     = "10.0.4.0/24"  # Different CIDR from other subnets
}

variable "public_subnet_2_az" {
  description = "Availability zone for second public subnet"
  type        = string
  default     = "ap-south-1c"  # Different AZ
} 