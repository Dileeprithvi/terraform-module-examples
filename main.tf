module "my_vpc"{
source = ".//modules/vpc"
region = "us-east-1"
vpc_pub_az = ["us-east-1a","us-east-1b"]
vpc_pri_az = ["us-east-1c","us-east-1d"]
}
