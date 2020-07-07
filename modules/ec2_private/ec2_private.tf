resource "aws_instance" "private-instance" {
# count = 2 referencing to deploy two instances in two private subnets with subnet_id
count = var.instance_count
# var.aws_ami is of type map. Taking the value of the region from the global variables
ami = lookup(var.aws_ami,var.ec2_region)
  
# taking the value of subnet_id from main.tf defined output logical name
  
subnet_id = element(data.terraform_remote_state.get_sg_subs.outputs.subnet2, count.index)
instance_type = "t2.micro"
key_name = var.key_name  
# taking the value of vpc_security_group_ids from main.tf defined output logical name  
  
vpc_security_group_ids = data.terraform_remote_state.get_sg_subs.outputs.sg2
  tags = merge(
    var.ec2_tags,
  {
    Name = "private-instance-${count.index + 1}"
  },
)
}


data "terraform_remote_state" "get_sg_subs" {
  backend = "local"
  config = {
    path = "/home/prithdileep/terraform-dileep/terraform.tfstate"
  }
}
