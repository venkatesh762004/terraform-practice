variable "aws_region" {
  description = "AWS region for the IAM lab"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for IAM resources"
  type        = string
  default     = "terraform-iam-day6"
}