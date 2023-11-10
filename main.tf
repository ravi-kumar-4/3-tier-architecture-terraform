module "my_vpc" {
    source = "./my-vpc"
    public_subnet_list = var.public_subnets
    private_subnet_list = var.private_subnets
    availability_zone = var.availability_zones
    bostion_subnet = var.bostion_subnet

}

module "my_webserver" {
    source = "./servers"
    availability_zones = var.availability_zones
    private_subnet_ids = module.my_vpc.private_subnet_ids
    public_subnet_ids = module.my_vpc.public_subnet_ids
    my_vpc_id = module.my_vpc.my_vpc

    
    image_id = var.image_id
    instance_type = var.instance_type
    key_name = var.key_name

    
    db_password = var.db_password
    db_user_name = var.db_username
}