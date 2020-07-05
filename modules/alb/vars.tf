variable "internal" {
description = "Describing about the Internal or Internet faced Load balancer"
  type        = bool
  default     = false
}


variable "loadbalancer" {
description = "Type of the loadbalancer"
default = "application"
}


variable "mod_vpc_sg_value" {
description = "Sg ID fetched from the modules/vpc/sg.tf (output) - mentioned in main.tf"
}


variable "mod_vpc_pub_subnet_value" {
description = "Public subnets value fetched from modules/vpc/vpc.tf (output) - mentioned in main.tf "
  type        = list(string)
}


variable "mod_vpc_id_value" {
description = "VPC ID fetched from the modules/vpc/vpc.tf (output) - mentioned in main.tf"
}



variable "web_instances-1" {
description = "taking two outputs of modules/ec2/ec2.tf"
}


variable "web_instances-2" {
description = "taking two outputs of modules/ec2/ec2.tf"
}
