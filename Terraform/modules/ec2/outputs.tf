# EC2 Module Outputs
# This file defines all outputs from the EC2 module
# These outputs can be referenced by other modules or the root module

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.main.id
}

output "instance_arn" {
  description = "ARN of the created EC2 instance"
  value       = aws_instance.main.arn
}

output "instance_public_ip" {
  description = "Public IP address of the created EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the created EC2 instance"
  value       = aws_instance.main.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the created EC2 instance"
  value       = aws_instance.main.public_dns
}

output "instance_private_dns" {
  description = "Private DNS name of the created EC2 instance"
  value       = aws_instance.main.private_dns
}

output "instance_state" {
  description = "Current state of the EC2 instance"
  value       = aws_instance.main.instance_state
}

output "instance_type" {
  description = "Instance type of the created EC2 instance"
  value       = aws_instance.main.instance_type
}

output "availability_zone" {
  description = "Availability zone of the created EC2 instance"
  value       = aws_instance.main.availability_zone
}

output "subnet_id" {
  description = "Subnet ID where the EC2 instance is located"
  value       = aws_instance.main.subnet_id
}



output "security_group_id" {
  description = "ID of the security group attached to the EC2 instance"
  value       = aws_security_group.ec2_sg.id
}

output "security_group_name" {
  description = "Name of the security group attached to the EC2 instance"
  value       = aws_security_group.ec2_sg.name
}

output "root_block_device" {
  description = "Root block device configuration of the EC2 instance"
  value       = aws_instance.main.root_block_device
}