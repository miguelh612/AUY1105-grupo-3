variable "AUY1105-webapp-public-subnet-1_id" {
  type = string
}

variable "AUY1105-webapp-public-subnet-2_id" {
  type = string
}

variable "AUY1105-webapp-sg_ec2_id" {
  type = string
}

variable "AUY1105-webapp-vpc_id" {
  type = string

}

variable "ami_ubuntu" {
  description = "AMI de Ubuntu para EC2"
  type        = string
  default     = "ami-0ec10929233384c7f"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}