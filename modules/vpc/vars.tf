variable "vpc_cidr" {
description = "VPC CIDR range"
default = "10.0.0.0/26"
}


variable "vpc_pub_az" {
description = "VPC Public Subnets"
type = list(string)
}


variable "vpc_pri_az" {
description = "VPC Private Subnets"
type = list(string)
}


variable "vpc_pub_CIDR" {
description = "VPC Public CIDRs"
type = list(string)
default = ["10.0.0.0/28","10.0.0.16/28"]
}


variable "vpc_pri_CIDR" {
description = "VPC Private CIDRs"
type = list(string)
default = ["10.0.0.32/28","10.0.0.48/28"]
}
