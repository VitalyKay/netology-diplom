resource "yandex_compute_instance" "gitlab-server-node" {
  name                      = "gitlab-server-node"
  zone                      = "ru-central1-b"
  hostname                  = "gitlab-server-node"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf"
      type        = "network-ssd"
      size        = "20"
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

resource "yandex_compute_instance" "gitlab-runner-node" {
  name                      = "gitlab-runner-node"
  zone                      = "ru-central1-b"
  hostname                  = "gitlab-runner-node"
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

resource "local_file" "deploy_key_private" {
  content = "${ tls_private_key.deploy_key.private_key_openssh }"
  filename = "../../ansible/roles/gitlab-runner-install/files/id_ed25519"
}
resource "local_file" "deploy_key_public" {
  content = "${ tls_private_key.deploy_key.public_key_openssh }"
  filename = "../../ansible/roles/gitlab-runner-install/files/id_ed25519.pub"
}
resource "local_file" "gitlab_user_key_public" {
  content = "${ tls_private_key.deploy_key.public_key_openssh }"
  filename = "../../ansible/roles/gitlab-ce-install/files/id_ed25519.pub"
}