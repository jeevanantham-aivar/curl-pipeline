# Staging environment configuration
# This file contains environment-specific values for the staging environment

# AWS region for staging
aws_region = "us-west-2"

# Environment identifier
environment = "staging"

# Project name
project_name = "terraform-example"

# EC2 variables
ami_id = "ami-0892d3c7ee96c0bf7"  # Amazon Linux 2 AMI in us-west-2
instance_type = "t3.small"
subnet_id = "subnet-87654321"  # Replace with actual subnet ID from your AWS account
ec2_tags = { 
  Name = "staging-ec2",
  Environment = "staging",
  Project = "terraform-example"
}
key_name = ""  # Leave empty if no key pair exists
volume_size = 16
volume_type = "gp3" 