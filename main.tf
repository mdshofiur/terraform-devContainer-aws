provider "aws" {
  region = "us-east-1"
}

module "dev_infra" {
  source = "./blueprint"

  // VPC configurations
  name     = "k3s_cluster"
  vpc_cidr = "10.0.0.0/16"


  // Public subnet configurations
  public_subnet_variables = [{
    public_subnet_name              = "public_subnet_1"
    public_subnet_cidr_block        = "10.0.1.0/24"
    public_subnet_availability_zone = "us-east-1a"
    public_subnet_allow_public_ip   = true
    vpc_id                          = module.dev_infra.vpc_id_output
    vpc_name                        = module.dev_infra.vpc_name_output
  }]


  aws_route_table_for_public_subnets = [{
    route_table_name = "public_route_table_1"
    vpc_id           = module.dev_infra.vpc_id_output
    routes = [
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
      },
      {
        cidr_block = "0.0.0.0/0"
        gateway_id = module.dev_infra.vpc_gatway_id_output
      }
    ]
  }]


  // Private subnet configurations
  private_subnet_variables = [{
    private_subnet_name              = "private_subnet_1"
    private_subnet_cidr_block        = "10.0.2.0/24"
    private_subnet_availability_zone = "us-east-1a"
    vpc_id                           = module.dev_infra.vpc_id_output
    vpc_name                         = module.dev_infra.vpc_name_output
   }
  ]

  aws_route_table_for_private_subnets = [{
    route_table_name = "private_route_table_1"
    vpc_id           = module.dev_infra.vpc_id_output
    routes = [
      {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
      }
    ]
  }]




}

