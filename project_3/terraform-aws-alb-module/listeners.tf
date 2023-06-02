resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type = "forward"
  }
}