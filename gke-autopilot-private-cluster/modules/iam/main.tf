resource "google_service_account" "gke_admin" {
  account_id   = "gke-admin-sa"
  display_name = "GKE Admin Service Account"
}

resource "google_project_iam_binding" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.gke_admin.email}",
  ]
}