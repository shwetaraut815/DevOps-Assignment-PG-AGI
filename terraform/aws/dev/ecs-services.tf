# ### Frontend ECS Service (ALB-attached)

# resource "aws_ecs_service" "frontend" {
#   name            = "${var.project_name}-${var.environment}-frontend"
#   cluster         = aws_ecs_cluster.this.id
#   task_definition = aws_ecs_task_definition.frontend.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets         = aws_subnet.private[*].id
#     security_groups = [aws_security_group.frontend.id]
#     assign_public_ip = false
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.frontend.arn
#     container_name   = "frontend"
#     container_port   = 3000
#   }

#   depends_on = [
#     aws_lb_listener.http
#   ]
# }

# ## Backend ECS Service (PRIVATE, no ALB)

# resource "aws_ecs_service" "backend" {
#   name            = "${var.project_name}-${var.environment}-backend"
#   cluster         = aws_ecs_cluster.this.id
#   task_definition = aws_ecs_task_definition.backend.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets         = aws_subnet.private[*].id
#     security_groups = [aws_security_group.backend.id]
#     assign_public_ip = false
#   }
# }

