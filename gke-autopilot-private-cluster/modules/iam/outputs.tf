output "gke_admin_role_assigned" {
  description = "Whether the GKE Admin role has been assigned"
  value       = google_project_iam_binding.gke_admin != null
}