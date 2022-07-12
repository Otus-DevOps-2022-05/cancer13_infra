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
}
