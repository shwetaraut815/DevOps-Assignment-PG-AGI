# Private DNS Namespace
resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "${var.project_name}.local"
  vpc  = aws_vpc.this.id
}

# Backend Service Discovery
resource "aws_service_discovery_service" "backend" {
  name = "backend"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      type = "A"
      ttl  = 10
    }
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

