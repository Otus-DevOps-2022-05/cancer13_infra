resource "yandex_lb_target_group" "lb_tg" {
  name      = "app-target-group"
  region_id = var.region_id

  target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.app.network_interface.0.ip_address}"
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "app-network-load-balancer"
  region_id = var.region_id

  listener {
    name = "app"
    port = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.lb_tg.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 9292
      }
    }
  }
}