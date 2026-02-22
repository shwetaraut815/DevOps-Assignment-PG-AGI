variable "project_name" {
  type        = string
  description = "Project name prefix"
  default     = "devops-assignment"
}

variable "environment" {
  type        = string
  default     = "dev"
}

variable "region" {
  default = "us-east-1"

}


variable "task_count" {
  type    = number
  default = 1


}

variable "cpu" {
  type    = number
  default = 1024

}

variable "memory" {
  type    = number
  default = 2048

}
