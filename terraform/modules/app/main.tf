terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.76.0"
    }
  }
}
resource "yandex_compute_instance" "app" {
  count = 1
  name = "reddit-app-${count.index}"
  labels = {
    tags = "reddit-app"
  }
  resources {
    core_fraction = 20 # for economy
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  // provisioner "file" {
  //   source      = "${path.module}/files/reddit.service"
  //   destination = "/tmp/reddit.service"
  // }
  // provisioner "remote-exec" {
  //   script = "${path.module}/files/deploy.sh"
  // }
  // provisioner "remote-exec" { # https://github.com/hashicorp/terraform/issues/18517
  //   inline = [
  //     "exit 0"
  //   ]
  // }
}
