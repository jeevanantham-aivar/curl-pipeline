
# Output values from the EC2 module
output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the created EC2 instance"
  value       = module.ec2.instance_public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the created EC2 instance"
  value       = module.ec2.instance_private_ip
}

output "security_group_id" {
  description = "ID of the security group attached to the EC2 instance"
  value       = module.ec2.security_group_id
}

output "instance_arn" {
  description = "ARN of the created EC2 instance"
  value       = module.ec2.instance_arn
}

output "instance_type" {
  description = "Instance type of the created EC2 instance"
  value       = module.ec2.instance_type
}

output "availability_zone" {
  description = "Availability zone of the created EC2 instance"
  value       = module.ec2.availability_zone
} 