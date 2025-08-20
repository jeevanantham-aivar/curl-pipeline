# EC2 Module Variables
# This file defines all variables required by the EC2 module
# All values must be provided from the root module via terraform.tfvars

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  
  validation {
    condition     = length(var.ami_id) > 0
    error_message = "AMI ID cannot be empty."
  }
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  
  validation {
    condition     = length(var.instance_type) > 0
    error_message = "Instance type cannot be empty."
  }
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
  
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "Subnet ID cannot be empty."
  }
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Name of the EC2 key pair to use for SSH access"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script to run when the instance starts"
  type        = string
  default     = ""
}

variable "user_data_base64" {
  description = "Base64 encoded user data script"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "Enable detailed monitoring for the EC2 instance"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "IAM instance profile to attach to the EC2 instance"
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "ec2_tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
  
  validation {
    condition     = var.volume_size >= 8
    error_message = "Volume size must be at least 8 GB."
  }
}

variable "volume_type" {
  description = "Type of the root volume (gp2, gp3, io1, io2, st1, sc1)"
  type        = string
  default     = "gp3"
  
  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1"], var.volume_type)
    error_message = "Volume type must be one of: gp2, gp3, io1, io2, st1, sc1."
  }
}

variable "delete_on_termination" {
  description = "Whether to delete the root volume when the instance is terminated"
  type        = bool
  default     = true
}
variable "vpc_id" {
  description = "Type of the root volume"
  type        = string
  
}