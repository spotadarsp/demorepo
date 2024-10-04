resource "aws_lb" "devops_ec_instance_lb" {
  name               = var.lb_name
  internal           = var.is_external
  load_balancer_type = var.lb_type
  security_groups    = var.alb_sg
  subnets            = [var.public_subnet1, var.public_subnet2]

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "vega_lb_listner" {
  load_balancer_arn = aws_lb.devops_ec_instance_lb.arn
  port              = var.lb_listner_port
  protocol          = var.lb_listner_protocol

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = aws_lb_target_group.devops-target_grp.arn
  }
}

resource "aws_lb_target_group" "devops-target_grp" {
  name     = var.target_grp_name    
  port     = var.target_grp_port
  protocol = var.target_grp_protocol
  vpc_id   = var.main_vpc
  target_type = var.target_type_tg

  health_check {
    path                = "/health"
    port                = var.target_grp_port  # Updated to match target group port
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 5                    # Increased timeout for better reliability
    interval            = 30                   # Increased interval
    matcher             = "200"                # Ensure your application returns HTTP 200 on /login
  }

}



resource "aws_lb_target_group_attachment" "lb_attachment" {
  target_group_arn = aws_lb_target_group.devops-target_grp.arn
  target_id        = var.aws_instance_id
  port             = var.lb_target_group_attachment_port
}  