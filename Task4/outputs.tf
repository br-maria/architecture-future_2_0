output "network_id" {
  value       = yandex_vpc_network.this.id
  description = "ID VPC network"
}

output "public_subnet_id" {
  value       = yandex_vpc_subnet.public.id
  description = "ID public subnet"
}

output "private_subnet_a_id" {
  value       = yandex_vpc_subnet.private_a.id
  description = "ID private subnet A"
}

output "private_subnet_b_id" {
  value       = yandex_vpc_subnet.private_b.id
  description = "ID private subnet B"
}
