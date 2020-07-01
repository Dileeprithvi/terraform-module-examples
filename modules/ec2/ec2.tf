resource "aws_instance" "web-instance" {
# count = 2 referencing to deploy two instances in two public subnets with subnet_id  
count = var.instance_count
ami = var.aws_ami
subnet_id = element(var.mod_vpc_subs, count.index)
instance_type = "t2.micro"
key_name = var.key_name
iam_instance_profile = var.mod_iam_name  
user_data = file("${path.module}/httpd.sh")
vpc_security_group_ids = var.mod_vpc_pub_sg
  tags = {
    Name = "web-instance-${count.index + 1}"
  }
}

