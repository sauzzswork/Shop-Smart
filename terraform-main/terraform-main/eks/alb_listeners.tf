# resource "aws_lb_listener" "public_http" {
#   load_balancer_arn = aws_lb.public_alb.arn
#   port              = 80
#   protocol          = "HTTP"
#
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.traefik_tg_public.arn
#   }
# }
#
# resource "aws_lb_listener" "public_https" {
#   load_balancer_arn = aws_lb.public_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.acm_public_cert_arn
#
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.traefik_tg_public_https.arn
#   }
# }

resource "aws_lb_listener" "private_http" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.traefik_tg_private.arn
  }
}

# resource "aws_lb_listener" "private_https" {
#   load_balancer_arn = aws_lb.private_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.acm_public_cert_arn
#
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.traefik_tg.arn
#   }
# }