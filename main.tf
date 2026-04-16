module "network" {
  source = "./modules/network"
}

module "ec2" {
  source                            = "./modules/ec2"
  AUY1105-webapp-public-subnet-1_id = module.network.public_subnet_1
  AUY1105-webapp-public-subnet-2_id = module.network.public_subnet_2
  AUY1105-webapp-sg_ec2_id          = module.network.sg_ec2_id
  AUY1105-webapp-vpc_id             = module.network.main_vpc_id
}