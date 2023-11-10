resource "aws_launch_configuration" "web_instance_configuration" {
  name_prefix                 = "web_instance"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = [aws_security_group.web_instance_sg.id]
  associate_public_ip_address = true
  user_data                   = <<-EOD
    #! bin/bash
    sudo apt update -y
    sudo apt install nginx y
    sudo systemctl start nginx 
    systemctl enable nginx
 EOD
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_lb_target_group" "web_lb_tg" {
  name_prefix = "web"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.my_vpc_id
}

resource "aws_autoscaling_group" "web_asg" {
  name_prefix          = "web_"
  launch_configuration = aws_launch_configuration.web_instance_configuration.id
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = [aws_lb_target_group.web_lb_tg.arn]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_alb_sg.id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }

}
