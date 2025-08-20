# Main Terraform configuration file
# This file serves as the entry point for the Terraform project
# It configures the AWS provider and calls the EC2 module

terraform {
  required_version = ">= 1.0"
  
  # Configure required providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
# The region will be loaded from environment-specific tfvars files
provider "aws" {
  region = var.aws_region
  
  # Default tags for all resources
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  }
}


# Call the EC2 module to create compute resources
module "ec2" {
  source = "./modules/ec2"
  
  # Pass EC2 variables to the module
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  subnet_id                 = var.subnet_id
  vpc_security_group_ids    = []
  key_name                  = var.key_name
  ec2_tags                  = var.ec2_tags
  volume_size               = var.volume_size
  volume_type               = var.volume_type
  monitoring                = false
  associate_public_ip_address = true
  vpc_id=var.vpc_id
  
  # User data script for web server setup
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from ${var.environment} environment!</h1>" > /var/www/html/index.html
              echo "<p>Subnet: ${var.subnet_id}</p>" >> /var/www/html/index.html
              echo "<p>Instance Type: ${var.instance_type}</p>" >> /var/www/html/index.html
              echo "<p>Volume Size: ${var.volume_size}GB</p>" >> /var/www/html/index.html
              echo "<p>Volume Type: ${var.volume_type}</p>" >> /var/www/html/index.html
              EOF
}
