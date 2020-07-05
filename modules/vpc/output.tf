# The below output describes all the two public subnet ids without tuple form

output "subnets" {
  value = aws_subnet.public.*.id
}

# The below output describes all the two subnet ids with tuple form

#output "subnets" {
 # value = [aws_subnet.public.*.id]
#} --> Referencing one subnet to one aws ec2 ( modules/ec2/ec2.tf), then edit ec2.tf under subnet_id = var.mod_vpc_subs[0][0] or var.mod_vpc_subs[0][1] ---> the two array because of the output gives two subnets




# The below output describes Second [1] subnet id

output "subnets_single" {
  value = [aws_subnet.public.1.id]
}

# The below output describes vpc id

output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}

# The below output describes Public subnet group

output "sg_pub_id" {
  value = [aws_security_group.sg_public.id]
}



# The below output describes all the two private subnet ids without tuple form

output "subnets" {
  value = aws_subnet.private.*.id
}

# The below output describes Private subnet group

output "sg_pri_id" {
  value = [aws_security_group.sg_private.id]
}



