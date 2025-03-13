module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version = "~> 24.0"

  project_id              = var.project_id
  name                    = "gke-autopilot-cluster"
  region                  = var.region
  network                 = var.network
  subnetwork              = var.subnetwork
  master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  enable_private_endpoint = true
  enable_private_nodes    = true

  # Reference the secondary IP ranges defined in the VPC subnet
  ip_range_pods           = "pods-range"
  ip_range_services       = "services-range"

  # Set vertical pod autoscaling directly as a variable
  enable_vertical_pod_autoscaling = true

  # Set master authorized networks directly
  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.0/8"  # Example private IP range
      display_name = "private-network"
    }
  ]
}