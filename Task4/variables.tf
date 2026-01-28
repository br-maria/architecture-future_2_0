variable "project_name" {
  description = "Имя проекта (для нейминга ресурсов)"
  type        = string
  default     = "budushchee20"
}

variable "environment" {
  description = "Окружение: dev/stage/prod"
  type        = string
  default     = "dev"
}


variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

# --- Regions / Zones ---
variable "zone_a" {
  description = "Зона для ресурсов A"
  type        = string
  default     = "ru-central1-a"
}

variable "zone_b" {
  description = "Зона для ресурсов B"
  type        = string
  default     = "ru-central1-b"
}

# --- Networking ---
variable "vpc_cidr" {
  description = "CIDR VPC (используется для внутренних правил SG)"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR публичной подсети (bastion)"
  type        = string
  default     = "10.10.0.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR приватной подсети A"
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR приватной подсети B"
  type        = string
  default     = "10.10.2.0/24"
}

variable "allowed_ssh_cidr" {
  description = "CIDR, откуда разрешён SSH на bastion"
  type        = string
  default     = "0.0.0.0/0"
}

# --- SSH metadata ---
variable "ssh_user" {
  description = "Linux user для SSH (по умолчанию ubuntu)"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "Публичный SSH ключ (строка вида 'ssh-ed25519 AAA...')"
  type        = string
}

# --- Compute sizing ---
variable "platform_id" {
  description = "Платформа ВМ (standard-v1/v2)"
  type        = string
  default     = "standard-v1"
}

variable "core_fraction" {
  description = "Доля CPU (5/20/50/100)"
  type        = number
  default     = 20
}

variable "bastion_cores" {
  type    = number
  default = 2
}

variable "bastion_memory_gb" {
  type    = number
  default = 2
}

variable "private_cores" {
  type    = number
  default = 2
}

variable "private_memory_gb" {
  type    = number
  default = 4
}

variable "bastion_root_gb" {
  description = "Размер root диска bastion (GiB)"
  type        = number
  default     = 20
}

variable "private_root_gb" {
  description = "Размер root диска private VM (GiB)"
  type        = number
  default     = 30
}

# --- Data disks ---
variable "data_platform_data_gb" {
  description = "Доп. диск data platform (GiB)"
  type        = number
  default     = 100
}

variable "bi_portal_data_gb" {
  description = "Доп. диск BI/Portal (GiB)"
  type        = number
  default     = 50
}

# --- Image ---
variable "image_family" {
  description = "Семейство образов для ВМ"
  type        = string
  default     = "ubuntu-2204-lts"
}
