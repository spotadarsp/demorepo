resource "aws_instance" "devops_ec2_instance" {
  ami           = var.ami_id   #ami-0866a3c8686eaeeba
  instance_type = var.instance_type
  vpc_security_group_ids  = var.security_gps
  associate_public_ip_address = var.enable_public_ip_address
#   key_name                    = "jenkins-ec2-key"
  subnet_id                   = var.public_subnetid
  user_data = var.user_data_install_apache
  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
  tags = {
    Name = var.instance_name
  }
}
