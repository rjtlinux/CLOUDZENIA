output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.wordpress.dns_name
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.wordpress.name
} 