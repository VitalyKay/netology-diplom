resource "yandex_compute_instance" "mysql-master-node" {
  name                      = "mysql-master-node"
  zone                      = "ru-central1-a"
  hostname                  = "mysql-master-node"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.private-subnet.id}"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
}

resource "yandex_compute_instance" "mysql-slave-node" {
  name                      = "mysql-slave-node"
  zone                      = "ru-central1-a"
  hostname                  = "mysql-slave-node"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.private-subnet.id}"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
    serial-port-enable = 1
  }
}

