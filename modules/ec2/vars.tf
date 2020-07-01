variable "aws_ami" {
description = "AWS region for hosting our your network"
default = "ami-09d95fab7fff3776c"
}

variable "instance_count" {
default = "2"
}

variable "key_name" {
description = "Key name for SSH into EC2"
default = "awskey1"
}


variable "region" {
}

# value is given in the main.tf ( Two Public subnets values are fetched from the vpc module output )

variable "mod_vpc_subs" {
type = list(string)
}

# value is given in the main.tf ( Public Security Group value are fetched from the vpc module output )

variable "mod_vpc_pub_sg" {
}

