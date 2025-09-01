# Development environment configuration
# This file contains environment-specific values for the dev environment

# AWS region for development
aws_region = "ap-south-1"

# Environment identifier
environment = "prod"

# Project name
project_name = "security-scan-pipeline-updatef"

# EC2 variables
ami_id = "ami-0144277607031eca2"  # Amazon Linux 2 AMI in us-east-1
instance_type = "t2.micro"
subnet_id = "subnet-0898fa0466a1df036"  # Replace with actual subnet ID from your AWS account
ec2_tags = { 
  Name = "SS-ec2",
  Environment = "dev",
  Project = "terraform-example"
}
key_name = "ozi-keypair"  # Leave empty if no key pair exists
volume_size = 8
volume_type = "gp3" 
vpc_id="vpc-02212b4b11f3103d7"