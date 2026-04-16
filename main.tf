module "network" {
  source = "./modules/network"
}

module "compute" {
  source           = "./modules/compute"
  PublicSubnet1_id = module.network.public_subnet_1
  PublicSubnet2_id = module.network.public_subnet_2
  sg_frontend_id   = module.network.sg_ec2_id
  vpc_1_id         = module.network.main_vpc_id
}