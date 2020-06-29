# The below output describes all the two subnet ids

output "subnets" {
  value = [aws_subnet.public.*.id]
}


# The below output describes first [0] subnet id

output "subnets_single" {
  value = [aws_subnet.public.0.id]
}

# The below output describes the id of the VPC

output "vpc_id" {
  value = [aws_vpc.terraform_vpc.id]
}
