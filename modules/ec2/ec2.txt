resource "aws_instance" "web-instance" {
# count = 2 referencing to deploy two instances in two public subnets with subnet_id
count = var.instance_count
# var.aws_ami is of type map. Taking the value of the region from the global variables
ami = lookup(var.aws_ami,var.ec2_region)
  
# taking the value of subnet_id from main.tf defined output logical name
  
subnet_id = element(data.terraform_remote_state.get_pub_sg_subs.outputs.subnet1, count.index)
instance_type = "t2.micro"
key_name = var.key_name
user_data = file("${path.module}/httpd.sh")
  
# taking the value of vpc_security_group_ids from main.tf defined output logical name  
  
vpc_security_group_ids = data.terraform_remote_state.get_pub_sg_subs.outputs.sg1
  tags = merge(
    var.ec2_tags,
  {
    Name = "web-instance-${count.index + 1}"
  },
)
}


data "terraform_remote_state" "get_pub_sg_subs" {
  backend = "local"
  config = {
    path = "/home/prithdileep/terraform-dileep/terraform.tfstate"
  }
}
