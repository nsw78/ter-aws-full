output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "ID do Security Group criado para a EC2"
  value       = aws_security_group.ssh.id
}