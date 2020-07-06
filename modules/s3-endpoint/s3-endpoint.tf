# Creation of the bucket for testing the connection between ec2 private instances and s3

resource "aws_s3_bucket" "private_bucket_creation" {
  bucket = "testingmyvpc"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "trial"
  }
}


resource "aws_vpc_endpoint" "s3" {
vpc_id       = var.vpc
			
# service_name = us-east-1			
  service_name = "com.amazonaws.us-east-1.s3"
}


resource "aws_vpc_endpoint_route_table_association" "routing" {
route_table_id  = var.pri_route_id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
