resource "aws_alb" "alb-internet" {
  name               = "alb-internet"
  internal           = var.internal
  load_balancer_type = var.loadbalancer
  security_groups    = var.mod_vpc_sg_value
  subnets            = var.mod_vpc_pub_subnet_value
	    enable_deletion_protection = true

  tags = {
    Environment = "trial"
  }
}



resource "aws_alb_target_group" "alb-web-target-group" {
  name     = "alb-web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id             = var.mod_vpc_id_value
health_check {
                path = "/index.html"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
  }
}

resource "aws_alb_listener" "aws_alb_listener" {
  load_balancer_arn = aws_alb.alb-internet.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-web-target-group.arn
  }
}

resource "aws_alb_target_group_attachment" "mod_ec2_web_inst" {

# taking the pub value of subnets i.e.. 2, pointing to target_id

  count = length(var.mod_vpc_pub_subnet_value)
  target_group_arn = aws_alb_target_group.alb-web-target-group.arn
  target_id        = element(var.web_instances,count.index)
  port             = 80
}
