module "VPC" {
  source         = "./VPC"
  vpc_name       = "My - ${terraform.workspace} - VPC"
  vpc_cidr_block = "10.0.0.0/22"

  Public_Subnet_name   = ["${terraform.workspace} - Public-SN-1", "${terraform.workspace} - Public-SN-2"]
  Public_subnet_AZ     = ["us-east-1a", "us-east-1b"]
  Public_SN_cidr_block = ["10.0.0.0/25", "10.0.0.128/25"]

  Private_Subnet_name   = ["${terraform.workspace} - Private-SN-1", "${terraform.workspace} - Private-SN-2"]
  Private_subnet_AZ     = ["us-east-1c", "us-east-1d"]
  Private_SN_cidr_block = ["10.0.1.0/25", "10.0.1.128/25"]

  IGW_name                 = "${terraform.workspace} -IGW"
  Public_route_table_name  = "${terraform.workspace} - Public - RT"
  Nat_Name                 = "${terraform.workspace} - NAT"
  Private_route_table_name = "${terraform.workspace} - Private - RT"

}
module "SG" {
  source         = "./Security"
  vpc_idd        = module.VPC.aws_vpc_id
  SG_name        = "${terraform.workspace} - SG"
  sg_name        = "${terraform.workspace} - SG"
  SG_description = "It has all traffic"
  ports          = [22, 8080, 3306]
  sg_cidr_block  = ["0.0.0.0/0"]
}
module "LT" {
  source                        = "./Launch_Template"
  launch_template_name          = "${terraform.workspace} - LT_Instance"
  launch_temp_description       = "v1"
  LT_image_id                   = "ami-043a5a82b6cf98947"
  launch_template_instance_type = "t2.micro"
  LP_key_name                   = "MAHESH_EC2"
  LP_security_group             = [module.SG.SG_id]
}
module "Load_Balancer" {
  source             = "./ELB"
  name_elb           = "${terraform.workspace}ElasticLB"
  sub_1              = module.VPC.subnet_Subnet_id_1
  sub_2              = module.VPC.subnet_Subnet_id_2
  elb_security_group = [module.SG.SG_id]
}
module "ASG" {
  source              = "./ASG"
  asg_name            = "${terraform.workspace}-ASG"
  minimum_size        = 2
  maximum_size        = 5
  desired_capacity    = 2
  load_balancers      = [module.Load_Balancer.elb_name]
  vpc_zone_identifier = [module.VPC.subnet_Subnet_id_1, module.VPC.subnet_Subnet_id_2]
  tempalte_id         = module.LT.launch_template_id
}

