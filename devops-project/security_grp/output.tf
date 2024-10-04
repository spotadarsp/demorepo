output "sg_ec2" {
  value = aws_security_group.allow_tls_ec2_ssh.id
}


output "sg_rds" {
  value = aws_security_group.allow_tls_rds.id
}

output "sg_python" {
  value = aws_security_group.ec2_sg_python_api.id
}