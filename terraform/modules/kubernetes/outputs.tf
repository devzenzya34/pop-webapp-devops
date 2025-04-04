output "ec2_id" {
  value = aws_instance.ec2_pop_project_kubernetes.id
}

output "ec2_public_ip" {
  value = aws_instance.ec2_pop_project_kubernetes.public_ip
}