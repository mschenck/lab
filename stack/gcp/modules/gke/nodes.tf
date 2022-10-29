resource "google_container_node_pool" "default" {
  cluster            = var.cluster_name
  initial_node_count = var.min_node_count
  location           = "us-central1-a"
  name               = var.node_pool_name
  project            = var.project_id

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb      = 10
    disk_type         = "pd-standard"
    guest_accelerator = []
    image_type        = "COS_CONTAINERD"
    preemptible       = false
    service_account   = google_service_account.cluster_service_account.email
    local_ssd_count   = 0
    machine_type      = var.machine_type
    labels = {
      "cluster_name"      = var.cluster_name
      "default-node-pool" = "true"
      "node_pool"         = var.node_pool_name
    }

    metadata = {
      "cluster_name"                    = var.cluster_name
      "disable-legacy-endpoints"        = "true"
      "node-pool-metadata-custom-value" = "main-node-pool"
      "node_pool"                       = var.node_pool_name
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    tags = [
      "gke-gke-stack",
      "gke-gke-stack-default-node-pool",
      "default-node-pool",
    ]

    taint = [
      {
        effect = "PREFER_NO_SCHEDULE"
        key    = var.node_pool_name
        value  = "true"
      },
    ]

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  timeouts {
    create = "45m"
    delete = "45m"
    update = "45m"
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
