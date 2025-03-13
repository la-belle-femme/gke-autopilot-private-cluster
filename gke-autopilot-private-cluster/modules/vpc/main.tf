# Create the VPC
resource "google_compute_network" "vpc" {
  name                    = "gke-dev-vpc"
  auto_create_subnetworks = false
}

# Create the subnet with secondary IP ranges for pods and services
resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.name

  # Secondary IP range for pods
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.0.2.0/24"  # Replace with your desired pod IP range
  }

  # Secondary IP range for services
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.0.3.0/24"  # Replace with your desired service IP range
  }
}

# Firewall rule to allow SSH access to the bastion host
resource "google_compute_firewall" "bastion_ssh" {
  name    = "allow-bastion-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Restrict this to your IP in production
  target_tags   = ["bastion"]
}

# Firewall rule to allow internal communication within the VPC
resource "google_compute_firewall" "internal_communication" {
  name    = "allow-internal-communication"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/8"] # Allow all internal traffic
}

# Create Cloud Router
resource "google_compute_router" "router" {
  name    = "cloud-router"
  region  = var.region
  network = google_compute_network.vpc.name
}

# Create Cloud NAT
resource "google_compute_router_nat" "nat" {
  name                               = "cloud-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}