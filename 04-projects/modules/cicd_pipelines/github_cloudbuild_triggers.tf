# PR to main branch
resource "google_cloudbuild_trigger" "pr_trigger" {
  for_each = toset(var.cloudbuild_trigger_repos)
  provider = google-beta
  project  = var.app_cicd_project_id
  name     = "${each.key}-trigger"

  github {
    name  = "iac-gcp-foundation"
    owner = "rajesh-nitc"

    pull_request {
      branch          = "^main$"
      comment_control = "COMMENTS_ENABLED_FOR_EXTERNAL_CONTRIBUTORS_ONLY"
      invert_regex    = false
    }
  }

  included_files = ["${each.key}/**"]

  substitutions = {
    _GAR_REPOSITORY    = local.gar_name
    _DEFAULT_REGION    = var.primary_location
    _CACHE_BUCKET_NAME = google_storage_bucket.cache_bucket.name
    _CICD_BUILD_SA     = google_service_account.cicd_build_sa.email
  }

  filename = "${each.key}/${var.build_app_yaml}"
}