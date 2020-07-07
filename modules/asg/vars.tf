variable "get_vpc_sg" {
description = "Define the value in main.yml taken from the modules/vpc/outputs"
}



variable "get_pub_sub" {
description = "Define the value in main.yml taken from the modules/vpc/outputs"
type = list(string)
}


variable "get_alb_getdevelop" {
description = "Define the value in main.yml taken from the modules/alb/outputs"
}

variable "get_alb_gettesting" {
description = "Define the value in main.yml taken from the modules/alb/outputs"
}


variable "image" {
description = "image id of the us-east-1 amazon ami"
default = "ami-09d95fab7fff3776c"  
}
