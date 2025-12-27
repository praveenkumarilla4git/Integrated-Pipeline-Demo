variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "tf-key2"  # Make sure this matches your .pem file name
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 24.04 in us-east-1"
  default     = "ami-0e2c8caa4b6378d8c"
}

variable "bucket_name" {
  description = "S3 bucket for Terraform state"
  default     = "tf-state-praveen2-2025"
}