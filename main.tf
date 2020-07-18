# Below is the global variable mentioned for referencing the region

module "global_variables" {
  source= ".//modules/global_variables"
}

provider "aws" {
  region= module.global_variables.aws_region
}

    
module "my_vpc"{
source = ".//modules/vpc"

# Below are the variables present in the modules/vpc/vars.tf with no defined values there. Declaring the values below  
  
vpc_pub_az = ["us-east-1a","us-east-1b"]
vpc_pri_az = ["us-east-1c","us-east-1d"]
}

#Below are the four outputs referenced to "modules/ec2/ec2.tf" in the data.terraform.remote_state!!! The output's value fetched from declaring the output in the module/vpc/output.tf

# Below output will give two public subnets  
  
output "subnet1" {
  value = module.my_vpc.subnets
}

# Below output will give the public SG  
  
output "sg1" {
  value = module.my_vpc.sg_pub_id
}
  
# Below output will give two private subnets  
  
output "subnet2" {
  value = module.my_vpc.subnets2
}

# Below output will give the public SG  
  
output "sg2" {
  value = module.my_vpc.sg_pri_id
}  


/*  
# Commenting this because we are using asg. if uncommented, make sure the modules/alb has relative changes according to ec2  
  
module "my_ec2"{
source = ".//modules/ec2"
ec2_region = module.global_variables.aws_region     
# output logical name of aws_instance_profile from modules/iam/output.tf
mod_iam_name = module.my_iam.aws_instance_profile  
}
  
  
*/  

  
  
module "my_iam"{
source = ".//modules/iam"
} 

/*  
# Uncomment if we are using the ec2 module 
  
module "my_alb"{
source = ".//modules/alb"
mod_vpc_sg_value = module.my_vpc.sg_pub_id
mod_vpc_pub_subnet_value = module.my_vpc.subnets
mod_vpc_id_value = module.my_vpc.vpc_id
web_instances-1 = module.my_ec2.web_instance-1
web_instances-2 = module.my_ec2.web_instance-2
}
  
*/ 
  
# the below my_alb used for asg
  
module "my_alb"{
source = ".//modules/alb"
mod_vpc_sg_value = module.my_vpc.sg_pub_id
mod_vpc_pub_subnet_value = module.my_vpc.subnets
mod_vpc_id_value = module.my_vpc.vpc_id
}
  
  
module "my_route53"{
source = ".//modules/route53"
mod_alb_dns_name = module.my_alb.alb_dns_name
mod_alb_zone_id = module.my_alb.alb_zone_id
}
  
module "my_vpc_endpoint"{
source = ".//modules/s3-endpoint"
vpc = module.my_vpc.vpc_id
pri_route_id = module.my_vpc.pri_route_id
}  
  
  
module "my_asg"{
source = ".//modules/asg"
get_vpc_sg = module.my_vpc.sg_pub_id
get_pub_sub = module.my_vpc.subnets
get_alb_getdevelop = module.my_alb.alb_target_develop
get_alb_gettesting = module.my_alb.alb_target_testing
mod_iam_name = module.my_iam.aws_instance_profile   
}  
  
# Creation of the two private ec2 instances!!!
  
module "my_ec2_private"{
source = ".//modules/ec2_private"
ec2_region = module.global_variables.aws_region       
}
  
# Creation of the sftp server and CNAME record mapping to route53
# Pre -req: In null resource, make sure aws cli is installed in the machine, because we are using those commands in null resource!!!!  

module "my_sftp"{
source = ".//modules/sftp"
domain_name   = "sftp.dileeprithvi.tk"
zone_id       = "Z05297701GTHYRW9ZMY4R"
}

output "record" {
  value = module.my_sftp.record
}

  
  
