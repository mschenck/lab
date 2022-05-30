data "google_client_config" "default" {}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.location

  # Network
  network    = var.network_name
  subnetwork = var.subnetwork_name

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  default_max_pods_per_node   = 110
  enable_binary_authorization = false
  enable_kubernetes_alpha     = false
  enable_legacy_abac          = false
  enable_shielded_nodes       = true

  # Disable automatic node_pool
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    #cloudrun_config {
    #  disabled           = (known after apply)
    #  load_balancer_type = (known after apply)
    #}

    gcp_filestore_csi_driver_config {
      enabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    network_policy_config {
      disabled = true
    }
  }

  database_encryption {
    state = "DECRYPTED"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_subnet_name
    services_secondary_range_name = var.svcs_subnet_name
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "05:00"
    }
  }

  network_policy {
    enabled = false
  }

  timeouts {
    create = "45m"
    delete = "45m"
    update = "45m"
  }

  vertical_pod_autoscaling {
    enabled = false
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}
