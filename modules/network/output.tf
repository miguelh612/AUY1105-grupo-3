output "main_vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.AUY1105-webapp-vpc.id
}

output "public_subnet_1" {
  description = "ID de subred pública 1"
  value       = aws_subnet.AUY1105-webapp-public-subnet-1.id
}

output "public_subnet_2" {
  description = "ID de subred pública 2"
  value       = aws_subnet.AUY1105-webapp-public-subnet-2.id
}

output "private_subnet_1" {
  description = "ID de subred privada 1"
  value       = aws_subnet.AUY1105-webapp-private-subnet-1.id
}

output "private_subnet_2" {
  description = "ID de subred privada 2"
  value       = aws_subnet.AUY1105-webapp-private-subnet-2.id
}

output "sg_ec2_id" {
  description = "ID grupo de seguridad"
  value       = aws_security_group.AUY1105-webapp-sg_ec2.id
}
