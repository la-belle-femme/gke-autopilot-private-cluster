output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnets_names" {
  value = [google_compute_subnetwork.subnet.name]
}

output "cloud_router_name" {
  value = google_compute_router.router.name
}

output "cloud_nat_name" {
  value = google_compute_router_nat.nat.name
}