output "gke_cluster_name" {
  value = module.gke.cluster_name
}

output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "vpc_name" {
  value = module.vpc.network_name
}

output "cloud_router_name" {
  value = module.vpc.cloud_router_name
}

output "cloud_nat_name" {
  value = module.vpc.cloud_nat_name
}