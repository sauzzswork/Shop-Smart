# resource "tls_private_key" "ss_key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }
#
# resource "tls_self_signed_cert" "ss_cert" {
#   private_key_pem = tls_private_key.ss_key.private_key_pem
#
#   subject {
#     common_name  = "*.shopsmartsg.com"
#     organization = "ShopSmart"
#   }
#
#   validity_period_hours = 8760
#   early_renewal_hours   = 168
#   is_ca_certificate     = false
#
#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]
# }
#
# resource "kubernetes_secret" "central_hub_tls" {
#   metadata {
#     name      = "central-hub-tls"
#     namespace = kubernetes_namespace.shop_smart.metadata[0].name
#   }
#
#   data = {
#     "tls.crt" = base64encode(tls_self_signed_cert.ss_cert.cert_pem)
#     "tls.key" = base64encode(tls_private_key.ss_key.private_key_pem)
#   }
#
#   type = "kubernetes.io/tls"
# }
#
# resource "kubernetes_secret" "central_hub_tls_default" {
#   metadata {
#     name      = "central-hub-tls"
#     namespace = "default"
#   }
#
#   data = {
#     "tls.crt" = base64encode(tls_self_signed_cert.ss_cert.cert_pem)
#     "tls.key" = base64encode(tls_private_key.ss_key.private_key_pem)
#   }
#
#   type = "kubernetes.io/tls"
# }