terraform {
  backend "s3" {
    bucket = "cloudzenia-terraform-backend"
    key    = "hello-microservice-ecs/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1" 
}

data "aws_lb" "existing" {
  arn = "arn:aws:elasticloadbalancing:ap-south-1:935686097307:loadbalancer/app/cloudzenia-alb/8ad22c145ba048b2"
}

data "aws_vpc" "existing" {
  id = "vpc-0ee2acd9b6f1f54f5"
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
  
  tags = {
    Type = "Private" 
  }
}

data "aws_lb_listener" "existing" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:ap-south-1:935686097307:loadbalancer/app/cloudzenia-alb/8ad22c145ba048b2"
  port              = 443
}

resource "aws_cloudwatch_log_group" "hello_microservice" {
  name              = "/ecs/hello-microservice"
  retention_in_days = 30
}

resource "aws_lb_target_group" "hello_microservice" {
  name        = "microservice-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.existing.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher            = "200"
    path               = "/"
    port               = "traffic-port"
    timeout            = 5
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener_rule" "host_based" {
  listener_arn = data.aws_lb_listener.existing.arn
  priority     = 1  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hello_microservice.arn
  }

  condition {
    host_header {
      values = ["microservice.sainirajat.click"]
    }
  }
}

# Create ECS Task Definition
resource "aws_ecs_task_definition" "hello_microservice" {
  family                   = "hello-microservice"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_execution_role.arn
  task_role_arn           = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode(
    jsondecode(
      templatefile("task-definition.json", {
        aws_account_id = data.aws_caller_identity.current.account_id
        aws_region     = data.aws_region.current.name
      })
    )
  )
}

# Create ECS Service
resource "aws_ecs_service" "hello_microservice" {
  name            = "hello-microservice"
  cluster         = "cloudzenia-cluster"
  task_definition = aws_ecs_task_definition.hello_microservice.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-010d92447aeca0ea2", "subnet-00ba91332c27f07b1"]  # Replace with your actual subnet IDs
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hello_microservice.arn
    container_name   = "hello-microservice"
    container_port   = 3000
  }

  depends_on = [aws_lb_target_group.hello_microservice]
}

resource "aws_security_group" "ecs_service" {
  name        = "hello-microservice-ecs-service"
  description = "Security group for hello microservice ECS service"
  vpc_id      = data.aws_vpc.existing.id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = data.aws_lb.existing.security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "hello-microservice-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "hello-microservice-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "target_group_arn" {
  value = aws_lb_target_group.hello_microservice.arn
}

output "service_url" {
  value = "http://rajat.task.com"
}

# Add this back to your main.tf to prevent ECR repository deletion
resource "aws_ecr_repository" "microservice_repo" {
  name                 = "hello-microservice"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "private_subnet_ids" {
  value = data.aws_subnets.private.ids
}

# Add VPC Endpoints for ECR
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id             = data.aws_vpc.existing.id
  service_name       = "com.amazonaws.ap-south-1.ecr.dkr"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = data.aws_subnets.private.ids
  security_group_ids = [aws_security_group.vpc_endpoint.id]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id             = data.aws_vpc.existing.id
  service_name       = "com.amazonaws.ap-south-1.ecr.api"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = data.aws_subnets.private.ids
  security_group_ids = [aws_security_group.vpc_endpoint.id]

  private_dns_enabled = true
}

# Add data source for private route table
data "aws_route_table" "private" {
  vpc_id = data.aws_vpc.existing.id
  
  tags = {
    Name = "*private*"  # Update this tag to match your private route table's tag
  }
}

# Update the S3 VPC endpoint configuration
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.aws_vpc.existing.id
  service_name      = "com.amazonaws.ap-south-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = ["rtb-03b181264642534e2"]  
}

# Security group for VPC endpoints
resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc-endpoint-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = data.aws_vpc.existing.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Update ECS service security group to allow outbound HTTPS
resource "aws_security_group_rule" "ecs_to_vpce" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_service.id
  source_security_group_id = aws_security_group.vpc_endpoint.id
} 