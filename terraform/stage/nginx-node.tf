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

#resource "null_resource" "create_ssh_dir" {
# 
#  connection {
#    type     = "ssh"
#    host     = "${yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address}"
#    user     = "ubuntu"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "mkdir -p /home/ubuntu/.ssh",
#    ]
#  }
#}

#resource "null_resource" "copy-ssh-key" {
#  connection {
#    type     = "ssh"
#    host     = "${yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address}"
#    user     = "ubuntu"
#  }

#  provisioner "file" {
#    source      = "~/.ssh/id_ed25519"
#    destination = "/home/ubuntu/.ssh/id_ed25519"
#  }

#  depends_on = [
#    null_resource.create_ssh_dir
#  ]
#}

#resource "null_resource" "cmod-ssh-key" {
 
#  connection {
#    type     = "ssh"
#    host     = "${yandex_compute_instance.nginx-node.network_interface.0.nat_ip_address}"
#    user     = "ubuntu"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "chmod 600 /home/ubuntu/.ssh/id_ed25519",
#    ]
#  }
#}