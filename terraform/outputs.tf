output "external_ip_address_app" {
  value = yandex_compute_instance.app[count.index].network_interface[0].nat_ip_address
}

# output "external_ip_address_app-2" {
#   value = yandex_compute_instance.app-2.network_interface[0].nat_ip_address
# }

# output "external_ip_address_lb" {
#   value = yandex_lb_network_load_balancer.lb.listener[0].external_address_spec[0].address
# }