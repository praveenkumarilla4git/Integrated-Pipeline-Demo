terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Backend config cannot use variables, so we hardcode the bucket here
  backend "s3" {
    bucket = "tf-state-praveen2-2025"
    key    = "integrated-pipeline/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Security Group
resource "aws_security_group" "integrated_sg" {
  name        = "integrated_pipeline_sg"
  description = "Allow SSH, Jenkins, and App"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Jenkins Console"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "App Traffic"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. The Server
resource "aws_instance" "devops_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.integrated_sg.id]

  # Startup Script: Installs Java, Jenkins, Docker, and Ansible
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              
              # 1. Install Java & Jenkins
              sudo apt-get install -y fontconfig openjdk-17-jre
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update
              sudo apt-get install -y jenkins

              # 2. Install Docker
              sudo apt-get install -y docker.io
              sudo usermod -aG docker jenkins
              
              # 3. Install Ansible
              sudo apt-get install -y ansible
              
              # 4. Restart Services
              sudo systemctl restart jenkins
              EOF

  tags = {
    Name = "DevOps-Integrated-Server"
  }
}