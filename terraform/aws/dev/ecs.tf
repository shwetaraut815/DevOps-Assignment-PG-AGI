# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-cluster"
}

# Frontend ECS Service (ALB attached)
resource "aws_ecs_service" "frontend" {
  name            = "${var.project_name}-${var.environment}-frontend"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  health_check_grace_period_seconds = 15

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.frontend.id]
    assign_public_ip = true
  }

load_balancer {
  target_group_arn = aws_lb_target_group.frontend.arn
  container_name   = "frontend"
  container_port   = 3000
}

  depends_on = [
    aws_lb_listener.http
  ]
}

# Backend ECS Service (PRIVATE, service discovery enabled)
resource "aws_ecs_service" "backend" {
  name            = "${var.project_name}-${var.environment}-backend"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.backend.id]
    assign_public_ip = true
  }

 load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "backend"
    container_port   = 8000
  }
}

# resource "aws_ecs_cluster" "red" {
#   name = "red-hevean-devil"

# }

# resource "aws_ecs_service" "red" {
#   name    = "red"
#   cluster = aws_ecs_cluster.red.id

#   task_definition = aws_ecs_task_definition.red.family

#   desired_count = var.task_count

#   launch_type = "FARGATE"

#   health_check_grace_period_seconds = 15



#   network_configuration {
#     subnets          = data.aws_subnets.public_subnets.ids
#     security_groups  = [aws_security_group.kartik_sg.id]
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.red-target.arn
#     container_name   = "red-target"
#     container_port   = 3000

#   }
#     load_balancer {
#     target_group_arn = aws_lb_target_group.backend.arn
#     container_name   = "backend"
#     container_port   = 8000
#   }
#   depends_on = [aws_lb_listener.http]
# }




# resource "aws_ecs_task_definition" "this" {
#   family                   = "attendance"
#   execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
#   task_role_arn            = aws_iam_role.ecs-task-role.arn
#   requires_compatibilities = [ "FARGATE" ]
#   cpu                      = var.cpu
#   memory                   = var.memory
#   network_mode = "awsvpc"
#   container_definitions = jsonencode([
#     {
#       name      = "red-target"
#       image =  "249746593559.dkr.ecr.ap-south-1.amazonaws.com/devops-assignment-frontend:1.0"
#       # image = "${data.aws_ecr_repository.devops-assignment-frontend.repository_url}@${data.aws_ecr_image.latest.image_digest}"

#       cpu       = 512
#       memory    = 1024
#       essential = true
#       portMappings = [{
#         containerPort = 3000
        
#         protocol      = "tcp"
#       }]
#     },
#     {
#       name      = "backend"
#       image =  "249746593559.dkr.ecr.ap-south-1.amazonaws.com/devops-assignment-backend"
#       # image = "${data.aws_ecr_repository.devops-assignment-frontend.repository_url}@${data.aws_ecr_image.latest.image_digest}"

#       cpu       = 512
#       memory    = 1024
#       essential = true
#       portMappings = [{
#         containerPort = 8000
        
#         protocol      = "tcp"
#       }]
#     }
    
#   ])
  


# }