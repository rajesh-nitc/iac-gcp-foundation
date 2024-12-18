module "gke_cluster" {
  source                        = "../../modules/single_cluster"
  org_id                        = var.org_id
  environment                   = "development"
  app_name                      = "budita"
  region                        = var.default_region
  project_service_account       = var.project_service_account
  enable_private_endpoint       = false
  deploy_using_private_endpoint = false
  master_ipv4_cidr_block        = var.master_ipv4_cidr_block

  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0",
      display_name = "To test cicd on cloudbuild"
    }
  ]

  cluster_admin                                = "cluster-admin@budita.dev"
  this_user_can_only_authenticate_with_cluster = "rajesh@budita.dev"

  cluster_autoscaling = {
    enabled             = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    max_cpu_cores       = 50
    min_cpu_cores       = 1
    max_memory_gb       = 50
    min_memory_gb       = 1
    gpu_resources       = []
  }

  node_pools = [
    {
      name               = "np-${var.default_region}"
      machine_type       = "e2-standard-4"
      node_locations     = "us-central1-a"
      autoscaling        = true
      min_count          = 1
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    },
  ]

  # acm
  sync_repo   = "git@github.com:rajesh-nitc/iac-gcp-foundation.git" # This will require NAT
  sync_branch = "main"
  policy_dir  = "12-gke-platform-admins/budita-app/acm"
}
