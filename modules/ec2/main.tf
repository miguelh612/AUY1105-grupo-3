resource "aws_instance" "AUY1105-webapp-ec2" {
  ami           = var.ami_ubuntu
  instance_type = var.instance_type
  subnet_id     = var.AUY1105-webapp-public-subnet-1_id
  associate_public_ip_address = true
  key_name               = "vockey"
  vpc_security_group_ids = [var.AUY1105-webapp-sg_ec2_id]
  tags = {
    "Name" = "AUY1105-webapp-ec2"
  }
}