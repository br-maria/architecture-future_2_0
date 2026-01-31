terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.110"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id

}

# -----------------------------------------------------------------------------
# VPC-only конфигурация (без Compute/Disks/NAT Gateway/SG).
#
# Причина:
# - в папке запрещено создание VM (Compute Instances) политикой/ограничением
#   на уровне folder/organization, поэтому любые VM/диски/SG/NAT недоступны.
# - в рамках задачи зафиксирован инфраструктурный каркас (network/subnets), который
#   используется будущими доменами и сервисами.
# -----------------------------------------------------------------------------

# --- Network: VPC ---
resource "yandex_vpc_network" "this" {
  name = "${var.project_name}-${var.environment}-net"

  timeouts {
    create = "10m"
    delete = "10m"
  }
}

# --- Subnets ---
# Public subnet в зоне A
resource "yandex_vpc_subnet" "public" {
  name           = "${var.project_name}-${var.environment}-public"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.public_subnet_cidr]
}

# Private subnet A (также зона A)
resource "yandex_vpc_subnet" "private_a" {
  name           = "${var.project_name}-${var.environment}-private-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.private_subnet_a_cidr]
}

# Private subnet B (зона B)
resource "yandex_vpc_subnet" "private_b" {
  name           = "${var.project_name}-${var.environment}-private-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.private_subnet_b_cidr]
}
