# YC NAT-instance Ubuntu 18.04

resource "yandex_compute_instance" "nginx-node" {
  name                      = "nginx-node"
  zone                      = "ru-central1-a"
  hostname                  = "nginx-node"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd84mnpg35f7s7b0f5lg"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.public-subnet.id}"
    nat        = true
    nat_ip_address = var.yandex_external_ip 
    ip_address = "192.168.100.10"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
}

