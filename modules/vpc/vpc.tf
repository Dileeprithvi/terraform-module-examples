# Defining the VPC

resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_vpc"
  }
}

# Defining the VPC Public Subnet - Refer vars, will create two Public subnets

resource "aws_subnet" "public" {
  count = length(var.vpc_pub_CIDR)
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = element(var.vpc_pub_CIDR,count.index)
  availability_zone = element(var.vpc_pub_az,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-subnet-${count.index+1}"
  }
}

# Defining the VPC Private Subnet - Refer vars, will create two Private subnets

resource "aws_subnet" "private" {
  count = length(var.vpc_pri_CIDR)
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = element(var.vpc_pri_CIDR,count.index)
  availability_zone = element(var.vpc_pri_az,count.index)
  tags = {
    Name = "pri-subnet-${count.index+1}"
  }
}


# Defining the VPC Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "terraform_vpc_igw"
  }
}

# Defining the Elastic IP Address for NAT

resource "aws_eip" "nat" {
vpc      = true
}

# Defining the VPC NAT Gateway
# Allocating the subnet_id to the second public subnet

resource "aws_nat_gateway" "terraform_vpc_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.1.id
  depends_on = ["aws_internet_gateway.igw"]
  tags = {
    Name = "terraform_vpc_nat"
  }
}



# Defining the route table for public subnet

resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_Route"
  }
}

# Associating the Public subnet to the Internet exposed route table

resource "aws_route_table_association" "aws_rt_association" {
  count = length(var.vpc_pub_CIDR)
  route_table_id = aws_route_table.pub-route.id
  subnet_id = element(aws_subnet.public.*.id, count.index)
}

# Defining the route table for private subnet

resource "aws_route_table" "pri-route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terraform_vpc_nat.id
  }

  tags = {
    Name = "Private_Route"
  }
}

# Associating the Private subnet to the NAT exposed route table

resource "aws_route_table_association" "aws_rt_association2" {
  count = length(var.vpc_pri_CIDR)
  route_table_id = aws_route_table.pri-route.id
  subnet_id = element(aws_subnet.private.*.id, count.index)
}
