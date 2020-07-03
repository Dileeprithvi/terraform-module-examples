variable "aws_ami" {
description = "AWS region for hosting our your network"
type = map
    default = {
    us-east-1 = "ami-09d95fab7fff3776c"
    us-east-2 = "ami-06d5a8ce809b866ee"
  }
}

variable "ec2_region" {
}

variable "instance_count" {
default = "2"
}

variable "key_name" {
description = "Key name for SSH into EC2"
default = "awskey1"
}

variable "mod_iam_name" {
}  

variable "ec2_tags" {
  default = {
    Createdby               = "Dileep Prithvi"
    Role                    = "DevOps"
  }
}
