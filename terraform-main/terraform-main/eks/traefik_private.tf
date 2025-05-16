# resource "kubernetes_ingress_v1" "private_ingress" {
#   metadata {
#     name      = "private-ingress"
#     namespace = kubernetes_namespace.shop_smart.metadata.0.name
#     annotations = {
#       "kubernetes.io/ingress.class" = "traefik-private"
#     }
#   }
#
#   spec {
#     rule {
#       host = "profile-service.ss.aws.local"
#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "profile-service"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#
#     rule {
#       host = "product-service.ss.aws.local"
#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "product-service"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#
#     rule {
#       host = "order-service.ss.aws.local"
#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "order-service"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#     # Add more rules as needed for additional services
#   }
# }

resource "kubernetes_ingress_v1" "private_ingress" {
  metadata {
    name      = "private-ingress"
    namespace = kubernetes_namespace.shop_smart.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class" = "traefik-private"
      # "alb.ingress.kubernetes.io/target-group-arn" = aws_lb_target_group.traefik_tg_private.arn
    }
  }

  spec {
    dynamic "rule" {
      for_each = var.ingress_rules
      content {
        host = rule.value.host
        http {
          path {
            path      = "/"
            path_type = "Prefix"
            backend {
              service {
                name = rule.value.service_name
                port {
                  number = rule.value.service_port
                }
              }
            }
          }
        }
      }
    }
  }
}