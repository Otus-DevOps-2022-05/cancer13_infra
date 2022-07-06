resource "yandex_compute_instance" "app" {
  count = 2
  name = "reddit-app-${count.index}"
  zone = var.zone

  resources {
    core_fraction = 20 # for economy
    cores         = 2
    memory        = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app[count.index].network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "files/reddit.service"
    destination = "/tmp/reddit.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
  provisioner "remote-exec" { # https://github.com/hashicorp/terraform/issues/18517
    inline = [
      "exit 0"
    ]
  }
}