resource "google_compute_network" "network" {
   name                    = "${var.name}-k8s-network"
   project                 = var.project_id 
   routing_mode            = var.routing_mode
   auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
    name                   = "${var.name}-k8s-subnetwork"
    project                = var.project_id
    network                = google_compute_network.network.name
    
    region                 = var.region
    ip_cidr_range          = var.vpc_subnet_cidr
    secondary_ip_range     = [
        {
            ip_cidr_range = var.k8s_pods_subnet_cidr
            range_name    = var.k8s_pods_subnet_name
        },
        {
            ip_cidr_range = var.k8s_svcs_subnet_cidr
            range_name    = var.k8s_svcs_subnet_name
        }
    ]
    
    private_ip_google_access = true 
}