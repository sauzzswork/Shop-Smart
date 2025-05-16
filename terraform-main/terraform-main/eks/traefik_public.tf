# resource "kubernetes_ingress_v1" "public_ingress" {
#   metadata {
#     name      = "public-ingress"
#     namespace = kubernetes_namespace.shop_smart.metadata.0.name
#     annotations = {
#       "kubernetes.io/ingress.class" = "traefik-public"
#       "alb.ingress.kubernetes.io/certificate-arn" = var.acm_public_cert_arn
#       "alb.ingress.kubernetes.io/target-group-arn" = aws_lb_target_group.traefik_tg_public.arn
#     }
#   }
#
#   spec {
#     # tls {
#     #   hosts      = ["central-hub.shopsmartsg.com"]
#     #   secret_name = kubernetes_secret.central_hub_tls.metadata[0].name
#     # }
#
#     tls {
#       hosts      = ["central-hub.shopsmartsg.com"]
#       secret_name = kubernetes_secret.central_hub_tls_default.metadata[0].name
#     }
#
#     rule {
#       host = "central-hub.shopsmartsg.com"
#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = "central-hub"
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
