resource "aws_launch_configuration" "application_lc" {
    name_prefix     = "app_"
    image_id        = var.image_id
    instance_type   = var.instance_type
    key_name        = var.key_name
    security_groups = [aws_security_group.application_instance_sg.id]
    user_data       = <<-EOD
    #! bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    EOD
    lifecycle {
        create_before_destroy = true
    }
    

}

resource "aws_lb_target_group" "application_tg" {
    name_prefix = "app"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = var.my_vpc_id
}

resource "aws_autoscaling_group" "application_asg" {
    name_prefix          = "app_"
    launch_configuration = aws_launch_configuration.application_lc.name
    min_size             = 2
    max_size             = 4
    health_check_type    = "ELB"
    vpc_zone_identifier  = var.private_subnet_ids
    target_group_arns    = [aws_lb_target_group.application_tg.arn]

    lifecycle {
        create_before_destroy = true
    }
}
resource "aws_lb" "application_alb" {
    name_prefix        = "app"
    internal           = true
    load_balancer_type = "application"
    security_groups    = [aws_security_group.application_alb_sg.id]
    subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "application_alb_listener_1" {
    load_balancer_arn = aws_lb.application_alb.arn
    port              = "80"
    protocol          = "HTTP"                                                               
    default_action {                                                       
        type             = "forward"                                       
        target_group_arn = aws_lb_target_group.application_tg.arn   
    }                                                                      
}                                                                          


output "application_alb" {
    value = aws_lb.application_alb.dns_name
}