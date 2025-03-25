variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "secrets_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}

# Auto-scaling related variables
variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
  default     = "1024"
}

variable "task_memory" {
  description = "Memory for the task"
  type        = string
  default     = "2048"
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of tasks"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of tasks"
  type        = number
  default     = 4
}

variable "cpu_threshold" {
  description = "CPU threshold for scaling"
  type        = number
  default     = 70
}

variable "memory_threshold" {
  description = "Memory threshold for scaling"
  type        = number
  default     = 70
} 