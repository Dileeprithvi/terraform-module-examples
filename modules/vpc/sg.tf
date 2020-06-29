# Defining the Public Subnet Security Group

resource "aws_security_group" "sg_public" {
  name = "sg_public"
  description = "Allowing Internet Access"
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags = {
    Name = "sg_public_subnet"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}

# Defining the Private Subnet Security Group

resource "aws_security_group" "sg_private" {
  name = "sg_private"
  description = "Restricted Access"
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags = {
    Name = "sg_private_subnet"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_vpc.terraform_vpc.cidr_block]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}
