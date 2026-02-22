# resource "aws_iam_role" "ecs-task-role" {
#   name = "ecs-task-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"
#       }
#       Action = "sts:AssumeRole"

#       }

#     ]
#   })

# }


# resource "aws_iam_role" "ecs-task-execution-role" {
#   name = "ecs-task-execution-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         Service = "ecs-tasks.amazonaws.com"

#       }
#       Action = "sts:AssumeRole"
#     }]
#   })

 

# }


# resource "aws_iam_role_policy_attachment" "ecs_task_policy" {
#   role       = aws_iam_role.ecs-task-role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }


# # Attach AmazonECSTaskExecutionRolePolicy to Execution Role
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
#   role       = aws_iam_role.ecs-task-execution-role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# # Attach AmazonEC2ContainerRegistryReadOnly to Task Role
# resource "aws_iam_role_policy_attachment" "ecs_task_ecr_policy" {
#   role       = aws_iam_role.ecs-task-role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }