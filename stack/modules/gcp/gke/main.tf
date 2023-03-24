data "google_client_config" "default" {}

# GKE Network
resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.project_id
  routing_mode            = var.routing_mode
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  project       = var.project_id
  network       = google_compute_network.network.name
  region        = var.region
  ip_cidr_range = var.nodes_cidr_block

  secondary_ip_range = [
    {
      range_name    = var.pods_subnet_name,
      ip_cidr_range = var.pods_subnet_cidr
    },
    {
      range_name    = var.svcs_subnet_name,
      ip_cidr_range = var.svcs_subnet_cidr
    }
  ]

  private_ip_google_access = true
}

# GKE cluster
resource "google_container_cluster" "default" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.location

  # Network
  network    = var.network_name
  subnetwork = var.subnetwork_name

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  default_max_pods_per_node = 110
  enable_kubernetes_alpha   = false
  enable_legacy_abac        = false
  enable_shielded_nodes     = true

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

  depends_on = [
    google_compute_network.network,
    google_compute_subnetwork.subnetwork
  ]
}

module "Orchestration_kubeconfig" {
  source = "../../kubeconfig"

  ca_certificate = google_container_cluster.default.master_auth[0].cluster_ca_certificate
  endpoint       = "https://${google_container_cluster.default.endpoint}"
  cluster_name   = var.cluster_name
  user           = "default"
  client_token   = data.google_client_config.default.access_token

  depends_on = [
    google_container_cluster.default
  ]
}
