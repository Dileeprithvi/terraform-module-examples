resource "aws_alb" "alb-internet" {
  name               = "alb-internet"
  internal           = var.internal
  load_balancer_type = var.loadbalancer
  security_groups    = var.mod_vpc_sg_value
  subnets            = var.mod_vpc_pub_subnet_value
#  enable_deletion_protection = true
# Enabling enable_deletion_protection = true will not able to destroy the resources

  tags = {
    Environment = "trial"
  }
}



resource "aws_alb_target_group" "alb-web-target-group-1" {
  name     = "alb-web-target-group-1"
  port     = 80
  protocol = "HTTP"
  vpc_id             = var.mod_vpc_id_value
health_check {
                path = "/develop/index.html"
                protocol = "HTTP"
                port = "80"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
  }
}

resource "aws_alb_target_group" "alb-web-target-group-2" {
  name     = "alb-web-target-group-2"
  port     = 80
  protocol = "HTTP"
  vpc_id             = var.mod_vpc_id_value
health_check {
                path = "/testing/index.html"
                protocol = "HTTP"
                port = "80"
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
    target_group_arn = aws_alb_target_group.alb-web-target-group-1.arn
  }
}

resource "aws_lb_listener_rule" "my_rule" {
  listener_arn = aws_alb_listener.aws_alb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-web-target-group-1.arn
  }

  condition {
    path_pattern {
      values = ["/develop/"]
    }
  }
}

resource "aws_lb_listener_rule" "my_rule-2" {
  listener_arn = aws_alb_listener.aws_alb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-web-target-group-2.arn
  }
  condition {
    path_pattern {
      values = ["/testing/"]
    }
  }
}

                
