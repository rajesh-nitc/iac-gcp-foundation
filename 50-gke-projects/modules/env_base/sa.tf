locals {

  node_default_roles = [
    "roles/logging.logWriter",
    "roles/storage.objectViewer",
    "roles/monitoring.metricWriter",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/monitoring.viewer"
  ]

  node_cicd_roles_cicd_project = [
    "roles/artifactregistry.reader",
    "roles/source.reader"
  ]

}

# Allow nodes access to ops and artifactory
resource "google_service_account" "node_sa" {
  account_id = "node-sa"
  project    = module.gke_project.project_id
}

resource "google_project_iam_member" "node_sa_roles" {
  for_each = toset(local.node_default_roles)
  project  = module.gke_project.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.node_sa.email}"
}

resource "google_project_iam_member" "node_sa_cicd_roles" {
  for_each = toset(local.node_cicd_roles_cicd_project)
  project  = var.app_cicd_project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.node_sa.email}"
}

# Allow cicd-sa to deploy on cluster
# with "roles/container.developer" cicd-sa cannot create resource "clusterroles" in API group "rbac.authorization.k8s.io"
resource "google_project_iam_member" "cloudbuild_sa_role_gke_project" {
  project = module.gke_project.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${var.cicd_sa}"
}