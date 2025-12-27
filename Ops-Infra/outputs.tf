output "server_ip" {
  description = "The Public IP of the Jenkins/Ansible Server"
  value       = aws_instance.devops_server.public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = "http://${aws_instance.devops_server.public_ip}:8080"
}