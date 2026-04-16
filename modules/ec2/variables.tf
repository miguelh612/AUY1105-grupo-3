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
variable "ec2_specs" {
  description = "Configuración de instancia EC2"
  type = map(object({
    ami           = string
    instance_type = string
    disk_size     = number
    subnet_index  = number
    app_tag       = string
  }))

  default = {
    "auy1105-webapp-ec2" = {
      ami           = "ami-0ec10929233384c7f"
      instance_type = "t2.micro"
      disk_size     = 20
      subnet_index  = 0
      app_tag       = "auy1105-webapp-ec2"
    }
  }
}
