resource "google_compute_subnetwork_iam_member" "sa_dataflow_networkuser" {
  for_each   = contains(var.activate_apis, "dataflow.googleapis.com") && var.vpc_type != "" ? local.shared_vpc_subnets_map : {}
  member     = format("serviceAccount:%s", local.service_prj_dataflow_sa)
  project    = local.svpc_host_project_id
  region     = each.value.region
  role       = "roles/compute.networkUser"
  subnetwork = each.value.self_link
}