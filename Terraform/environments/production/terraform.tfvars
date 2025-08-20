# Production environment configuration
# This file contains environment-specific values for the production environment

# AWS region for production
aws_region = "us-east-1"

# Environment identifier
environment = "prod"

# Project name
project_name = "terraform-example"

# EC2 variables
ami_id = "ami-0c02fb55956c7d323"  # Amazon Linux 2 AMI in us-east-1
instance_type = "t3.small"
subnet_id = "subnet-11223344"  # Replace with actual subnet ID from your AWS account
ec2_tags = { 
  Name = "prod-ec2",
  Environment = "prod",
  Project = "terraform-example"
}
key_name = ""  # Leave empty if no key pair exists
volume_size = 20
volume_type = "gp3" 