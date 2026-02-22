resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "ecs-observability-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6

        properties = {
          title = "ECS CPU & Memory Utilization"
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.backend.name],
            ["AWS/ECS", "MemoryUtilization", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.backend.name]
          ]
          period = 60
          stat   = "Average"
          region = "ap-south-1"
        }
      },
      {
        type = "metric"
        x = 12
        y = 0
        width = 12
        height = 6

        properties = {
          title = "ALB Target Health"
          metrics = [
            ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", aws_lb_target_group.backend.arn_suffix, "LoadBalancer", aws_lb.this.arn_suffix],
            ["AWS/ApplicationELB", "UnHealthyHostCount", "TargetGroup", aws_lb_target_group.backend.arn_suffix, "LoadBalancer", aws_lb.this.arn_suffix]
          ]
          period = 60
          stat   = "Average"
          region = "ap-south-1"
        }
      },
      {
        type = "metric"
        x = 0
        y = 6
        width = 24
        height = 6

        properties = {
          title = "ALB 5XX Errors"
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", "LoadBalancer", aws_lb.this.arn_suffix]
          ]
          period = 60
          stat   = "Sum"
          region = "ap-south-1"
        }
      }
    ]
  })
}