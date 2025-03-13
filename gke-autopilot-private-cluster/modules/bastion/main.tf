resource "google_compute_instance" "bastion" {
  name         = "bastion-host"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }

  tags = ["bastion"]
}