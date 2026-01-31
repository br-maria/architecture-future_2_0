# ====== Credentials ======
cloud_id  = "b1gs26b45f1qnc030evp"
folder_id = "b1gqbqp6rfn89j72vjet"

# ====== SSH ======
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/ryxIrg693Iiwo8nCvCCSAr3TzQLXaTyfkAzHjjnF0 terraform"
ssh_user       = "ubuntu"

allowed_ssh_cidr = "0.0.0.0/0"

project_name = "budushchee20"
environment  = "dev"

zone_a = "ru-central1-a"
zone_b = "ru-central1-b"

vpc_cidr              = "10.10.0.0/16"
public_subnet_cidr    = "10.10.0.0/24"
private_subnet_a_cidr = "10.10.1.0/24"
private_subnet_b_cidr = "10.10.2.0/24"

platform_id   = "standard-v1"
core_fraction = 20

bastion_cores     = 2
bastion_memory_gb = 2
private_cores     = 2
private_memory_gb = 4

bastion_root_gb = 20
private_root_gb = 30

data_platform_data_gb = 100
bi_portal_data_gb     = 50

image_family = "ubuntu-2204-lts"
