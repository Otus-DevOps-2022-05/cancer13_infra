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
  subnet_id       = yandex_vpc_subnet.prod-subnet.id
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = yandex_vpc_subnet.prod-subnet.id
}
resource "yandex_vpc_network" "prod-network" {
  name = "prod-app-network"
}

resource "yandex_vpc_subnet" "prod-subnet" {
  name           = "prod-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.prod-network.id}"
  v4_cidr_blocks = ["10.0.2.0/24"]
}