# resource "aws_lb_target_group" "traefik_tg_public" {
#   name     = "traefik-tg-public"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_main_id
#   target_type = "ip"
#
#   # health_check {
#   #   path                = "/"
#   #   port                = "traffic-port"
#   #   protocol            = "HTTP"
#   #   matcher             = "200-399"
#   #   interval            = 30
#   #   timeout             = 5
#   #   healthy_threshold   = 2
#   #   unhealthy_threshold = 2
#   # }
#   tags = {
#     Name = "traefik-tg_public"
#   }
# }

# resource "aws_lb_target_group" "traefik_tg_public_https" {
#   name     = "traefik-tg-public-https"
#   port     = 443
#   protocol = "HTTPS"
#   vpc_id   = var.vpc_main_id
#   target_type = "ip"
#
#   # health_check {
#   #   path                = "/"
#   #   port                = "traffic-port"
#   #   protocol            = "HTTP"
#   #   matcher             = "200-399"
#   #   interval            = 30
#   #   timeout             = 5
#   #   healthy_threshold   = 2
#   #   unhealthy_threshold = 2
#   # }
#   tags = {
#     Name = "traefik-tg_public-https"
#   }
# }

resource "aws_lb_target_group" "traefik_tg_private" {
  name     = "traefik-tg-private"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_main_id
  target_type = "ip"

  # health_check {
  #   path                = "/"
  #   port                = "traffic-port"
  #   protocol            = "HTTP"
  #   matcher             = "200-399"
  #   interval            = 30
  #   timeout             = 5
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  # }
  tags = {
    Name = "traefik-tg_private"
  }
}
