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

output "subnet1" {
  value = module.my_vpc.subnets
}


output "sg1" {
  value = module.my_vpc.sg_pub_id
}


module "my_ec2"{
source = ".//modules/ec2"
  
# Below values in the format!! - module.(logical name of the module vpc---> my_vpc).{referencing the output logical names of modules/vpc/output.tf}
# my_vpc.subnets is a list(string) because the output contains two public subnet values
  
mod_vpc_subs = module.my_vpc.subnets
mod_vpc_pub_sg = module.my_vpc.sg_pub_id
  
# output logical name of aws_instance_profile from modules/iam/output.tf
mod_iam_name = module.my_iam.aws_instance_profile  
}

  
  
module "my_iam"{
source = ".//modules/iam"
} 
  
  
module "my_alb"{
source = ".//modules/alb"
mod_vpc_sg_value = module.my_vpc.sg_pub_id
mod_vpc_pub_subnet_value = module.my_vpc.subnets
mod_vpc_id_value = module.my_vpc.vpc_id
web_instances = module.my_ec2.web_instance
}
  

module "my_route53"{
source = ".//modules/route53"
mod_alb_dns_name = module.my_alb.alb_dns_name
mod_alb_zone_id = module.my_alb.alb_zone_id
}
  
  
  
  

  
  
  
  
