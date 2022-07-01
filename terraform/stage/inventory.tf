resource "local_file" "inventory" {
  content = <<-DOC
    ---
    nginx:
      hosts:
        nginx-node:
          ansible_host: ${yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address}
    mysql:
      hosts:
        mysql-master:
          ansible_host: ${yandex_compute_instance.mysql-master-node.network_interface.0.ip_address}
        mysql-slave:
          ansible_host: ${yandex_compute_instance.mysql-slave-node.network_interface.0.ip_address}
    wordpress:
      hosts:
        wordpress-node:
          ansible_host: ${yandex_compute_instance.wordpress-node.network_interface.0.ip_address}
    gitlab:
      hosts:
        gitlab-server:
          ansible_host: ${yandex_compute_instance.gitlab-server-node.network_interface.0.ip_address}
        gitlab-runner:
          ansible_host: ${yandex_compute_instance.gitlab-runner-node.network_interface.0.ip_address}
    monitoring:
      hosts:
        monitoring-node:
          ansible_host: ${yandex_compute_instance.monitoring-node.network_interface.0.ip_address}
    DOC
  filename = "../../ansible/inventory/inventory.yml"

  depends_on = [
    yandex_compute_instance.nginx-node,
    yandex_compute_instance.mysql-master-node,
    yandex_compute_instance.mysql-slave-node,
    yandex_compute_instance.wordpress-node,
    yandex_compute_instance.gitlab-server-node,
    yandex_compute_instance.gitlab-runner-node,
    yandex_compute_instance.monitoring-node
  ]
}
