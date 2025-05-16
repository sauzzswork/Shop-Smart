# resource "aws_lb" "public_alb" {
#   name               = "public-traefik-alb"
#   load_balancer_type = "application"
#   security_groups = [var.alb_public_sg_id]
#   subnets            = var.public_subnet_ids
#   internal           = false
#
#   enable_deletion_protection = false
#
#   tags = {
#     Name = "public-traefik-alb"
#   }
# }


resource "aws_lb" "private_alb" {
  name               = "private-traefik-alb"
  load_balancer_type = "application"
  security_groups    = [var.alb_private_sg_id]
  subnets            = var.private_subnet_ids
  internal           = true

  enable_deletion_protection = false

  tags = {
    Name = "private-traefik-alb"
  }
}