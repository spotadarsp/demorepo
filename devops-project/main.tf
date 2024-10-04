# modules
module "networking" {
  source               = "./networking"
  cidr_block           = "10.0.0.0/16"
  vpc_name             = "devops_vpc"
  # subnets
  public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24"]
  az_public_subnet     = ["ap-south-1a", "ap-south-1b"]
#   public_subnet        = "public_subnet_useast1"
  cidr_private_subent  = ["10.0.3.0/24", "10.0.4.0/24"]
  az_private_subnet    = ["ap-south-1c", "ap-south-1a"]
  private_subnet       = "private_subnet_apsouth1"
  # ig
  ig_name              = "vega_ig-1"
  #route table
  public_subnet_rt_1   = "vega_public_rt"
  private_subnet_rt_1  = "vega_private_rt"
}



# settinng up security group
module "security_grp" {
  source              = "./security_grp"
  vpc_id              = module.networking.vpc_id

  sg_ec2              = "security_grp_ec2_devops"
  devops_sg_1           = "devops_sg_1"

  sg_rds          = "security_grp_rds_devops"
  devops_sg_2           = "devops_rds_2"
  ec2_sg_name_for_python_api = "devops_pythonapp"
}

# setting up devops vm
module "devops_server" {
  source             = "./ec2_devops"
  public_subnetid    = module.networking.public_subnet[0]
  security_gps       = [module.security_grp.sg_ec2, module.security_grp.sg_python]

  ami_id             = "ami-0dee22c13ea7a9a67"
  instance_type      = "t2.micro"
  instance_name      = "devops_server"
  enable_public_ip_address = true
  user_data_install_apache = templatefile("./template/ec2_install_apache.sh", {})
} 

# setting up load balacer for devops project

module "load_balancer_devops" {
  source = "./load_balancer_dev"
  alb_sg = [module.security_grp.sg_ec2, module.security_grp.sg_python]
  public_subnet1 = module.networking.public_subnet[0]
  public_subnet2 = module.networking.public_subnet[1]
  lb_name = "devops-loadbalancer"
  is_external = false
  lb_type = "application"
  environment = "devops-environment"
  #target grp attributes
  target_grp_name = "tf-devops-lb-tg"
  target_grp_port  = 5000
  target_grp_protocol = "HTTP"
  main_vpc = module.networking.vpc_id
  target_type_tg = "instance"

  aws_instance_id = module.devops_server.jenkins_ec2_instance_id
  lb_target_group_attachment_port = 5000
  lb_listner_port = 80
  lb_listner_protocol = "HTTP"
  lb_listner_default_action = "forward"

}

# setting up rds

module "rds_instance" {
  source = "./rds"
  db_subnet_group_name = "rds-subnet-grp"
  subnet_groups = module.networking.private_subnet
  mysql_db_identifier = "mydb"
  mysql_username       = "dbuser"
  mysql_password       = "dbpassword"
  mysql_dbname         = "devprojdb"
  rds_mysql_sg_id  = module.security_grp.sg_rds
}
