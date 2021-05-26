/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# output "bin_auth_attestor_names" {
#   description = "Names of Attestors"
#   value       = [for attestor_name in var.attestor_names_prefix : module.attestors[attestor_name].attestor]
# }

# output "bin_auth_attestor_project_id" {
#   description = "Project ID where attestors get created"
#   value       = var.app_cicd_project_id
# }

output "boa_artifact_repo" {
  description = "GAR Repo created to store runner images"
  value       = google_artifact_registry_repository.image_repo.name
}

output "app_cicd_build_sa" {
  value = google_service_account.app_cicd_build_sa.email
}