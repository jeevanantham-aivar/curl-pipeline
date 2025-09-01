# EC2 Module Main Configuration
# This file defines the AWS EC2 instance and security group resources
# All resource values are sourced from variables to ensure flexibility

# Create a security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  # Name for the security group - derived from tags
  name_prefix = "security-scan-pipeline-sg"
  
  # Description for the security group
  description = "Security group for EC2 instance"
  
  # VPC ID - derived from the subnet ID
 
  
  # Ingress rule for SSH access (port 22)
  ingress {
    description = "SSH access from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Ingress rule for HTTP access (port 80)
  ingress {
    description = "HTTP access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Ingress rule for HTTPS access (port 443)
  ingress {
    description = "HTTPS access from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Egress rule for all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Apply tags to the security group
  tags = merge(
    var.ec2_tags,
    {
      Name = "sg-${var.ec2_tags["Name"] != null ? var.ec2_tags["Name"] : "ec2"}"
      Type = "EC2 Security Group"
    }
  )
}

# Data source to get subnet information
data "aws_subnet" "selected" {
  # Subnet ID - must be provided via variables
  id = var.subnet_id
}

# Create the EC2 instance
resource "aws_instance" "main" {
  # AMI ID for the instance - must be provided via variables
  ami = var.ami_id
  
  # Instance type - must be provided via variables
  instance_type = var.instance_type
  
  # Subnet ID where the instance will be launched - must be provided via variables
  subnet_id = var.subnet_id
  
  # Security group IDs - combines provided security groups with the created one
  vpc_security_group_ids = concat(
    var.vpc_security_group_ids,
    [aws_security_group.ec2_sg.id]
  )
  
  # Key pair name for SSH access - optional
  key_name = var.key_name != "" ? var.key_name : null
  
  # User data script - optional
  user_data = var.user_data != "" ? var.user_data : null
  
  # Base64 encoded user data - optional
  user_data_base64 = var.user_data_base64 != "" ? var.user_data_base64 : null
  
  # Enable detailed monitoring - configurable via variables
  monitoring = var.monitoring
  
  # IAM instance profile - optional
  iam_instance_profile = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  
  # Associate public IP address - configurable via variables
  associate_public_ip_address = var.associate_public_ip_address
  
  # Root block device configuration
  root_block_device {
    # Volume size in GB - must be provided via variab


    
    volume_size = var.volume_size
    
    # Volume type - configurable via variables
    volume_type = var.volume_type
    
    # Delete on termination - configurable via variables
    delete_on_termination = var.delete_on_termination
    
    # Encrypt the root volume
    encrypted = true
  }
  
  # Apply tags to the EC2 instance
  tags = merge(
    var.ec2_tags,
    {
      Name = var.ec2_tags["Name"] != null ? var.ec2_tags["Name"] : "ec2-instance"
      Type = "EC2 Instance"
      SecurityGroup = aws_security_group.ec2_sg.id
    }
  )
}