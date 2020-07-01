module "my_vpc"{
source = ".//modules/vpc"

# Below are the variables present in the modules/vpc/vars.tf with no defined values there. Declaring the values below  
  
region = "us-east-1"
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
region = "us-east-1"
  
# Below values in the format!! - module.(logical name of the module vpc---> my_vpc).{referencing the output logical names of modules/vpc/output.tf}
# my_vpc.subnets is a list(string) because the output contains two public subnet values
  
mod_vpc_subs = module.my_vpc.subnets
mod_vpc_pub_sg = module.my_vpc.sg_pub_id
}
  
