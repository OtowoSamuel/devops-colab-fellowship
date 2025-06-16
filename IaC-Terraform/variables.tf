# AWS Region
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# Project name for resource naming
variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "terraform-demo"
}

# Environment
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  
  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type."
  }
}

# Key pair name for EC2 instance access
variable "key_pair_name" {
  description = "Name of the AWS key pair for EC2 instance access"
  type        = string
  default     = ""
  
  validation {
    condition     = var.key_pair_name != ""
    error_message = "Key pair name must be provided for EC2 instance access."
  }
}
