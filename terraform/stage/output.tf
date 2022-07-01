output "internal_ip_address_nginx_node" {
  value = "${yandex_compute_instance.nginx-node.network_interface.0.ip_address}"
}

output "external_ip_address_nginx_node" {
  value = "${yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_wordpress_node" {
  value = "${yandex_compute_instance.wordpress-node.network_interface.0.ip_address}"
}
