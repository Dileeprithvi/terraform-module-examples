# Creating ASG and linking the ASG with the ALB of develop target group

locals {
  userdata1 = <<-USERDATA
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Default Page!!!!!</h1>" | sudo tee /var/www/html/index.html
mkdir -p /var/www/html/develop
sudo cd /var/www/html/develop
sudo touch index.thml
echo "<h1>Terraform Web Instance Launched Successfully from Develop (Module Example)!!!!!</h1>" | sudo tee /var/www/html/develop/index.html
  USERDATA
}

resource "aws_launch_configuration" "lc-develop" {
  name_prefix 				  = "lc-develop-"
  image_id                    = var.image
  instance_type               = "t2.micro"
  iam_instance_profile        = var.mod_iam_name
  security_groups             = var.get_vpc_sg

  user_data_base64            = base64encode(local.userdata1)
  
  lifecycle {
    create_before_destroy = true
  }
}  


resource "aws_autoscaling_group" "asg-develop" {
  name = "aws_launch_configuration.lc-develop.name-asg"

  min_size             = 1
  desired_capacity     = 1
  max_size             = 3
  health_check_type    = "ELB"
  target_group_arns	   = var.get_alb_getdevelop
  launch_configuration = aws_launch_configuration.lc-develop.name
  vpc_zone_identifier  = var.get_pub_sub

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Env"
    value               = "Develop"
    propagate_at_launch = true
  }
}

####################################################################################################################################


# Creating ASG and linking the ASG with the ALB of testing target group

locals {
  userdata2 = <<-USERDATA
#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Default Page!!!!!</h1>" | sudo tee /var/www/html/index.html
mkdir -p /var/www/html/testing
sudo cd /var/www/html/testing
sudo touch index.thml
echo "<h1>Terraform Web Instance Launched Successfully from Testing (Module Example)!!!!!</h1>" | sudo tee /var/www/html/testing/index.html
  USERDATA
}

resource "aws_launch_configuration" "lc-testing" {
  name_prefix 				  = "lc-testing-"
  image_id                    = var.image
  instance_type               = "t2.micro"
  iam_instance_profile        = var.mod_iam_name
  security_groups             = var.get_vpc_sg
  user_data_base64            = base64encode(local.userdata2)
  
  lifecycle {
    create_before_destroy = true
  }
}  


resource "aws_autoscaling_group" "asg-testing" {
  name = "aws_launch_configuration.lc-testing.name-asg"

  min_size             = 1
  desired_capacity     = 1
  max_size             = 3
  health_check_type    = "ELB"
  target_group_arns	   = var.get_alb_gettesting
  launch_configuration = aws_launch_configuration.lc-testing.name
  vpc_zone_identifier  = var.get_pub_sub

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Env"
    value               = "Testing"
    propagate_at_launch = true
  }
}
