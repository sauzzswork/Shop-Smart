resource "kubernetes_namespace" "shop_smart" {
  metadata {
    name = "shop-smart"
  }
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}