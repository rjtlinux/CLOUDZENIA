output "db_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.wordpress.endpoint
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.rds_credentials.arn
} 