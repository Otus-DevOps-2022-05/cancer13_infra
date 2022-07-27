terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.76.0"
    }
  }
}
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  private_key_path = var.private_key_path
  subnet_id       = yandex_vpc_subnet.stage-subnet.id
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = yandex_vpc_subnet.stage-subnet.id
}
resource "yandex_vpc_network" "stage-network" {
  name = "stage-app-network"
}
resource "yandex_vpc_subnet" "stage-subnet" {
  name           = "stage-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.stage-network.id}"
  v4_cidr_blocks = ["10.0.1.0/24"]
}

# generate inventory file for Ansible
resource "local_file" "ansible_inventory" {
  depends_on = [
    module.app,
    module.db
  ]
  content = templatefile("templates/inventry.j2",
    {
      app = module.app.external_ip_address_app
      bd = module.db.external_ip_address_db
    }
  )
  filename = "../../ansible/stage/inventory.yml"
}
