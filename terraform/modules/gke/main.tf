# data "google_compute_zones" "available" {
#     region = var.region
#     status = "UP"
# }

# data "google_container_engine_versions" "available" {
#     location = var.region
#     version_prefix = "${var.gke_version_prefix}."
# }

resource "google_container_cluster" "gke_cluster" {
    name = var.cluster_name
    location = var.zone

    network = var.network_self_link
    subnetwork = var.subnetwork_self_link

    remove_default_node_pool = true
    initial_node_count = 1

    deletion_protection = false

    release_channel {
        channel = "STABLE"
    }

}

resource "google_container_node_pool" "gke_node_pool" {
    name = "primary-node-pool"
    location = var.zone
    cluster = google_container_cluster.gke_cluster.name
    node_count = var.node_count

    node_config {
        machine_type = var.node_machine_type
        disk_size_gb = 30

        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]

        tags = ["gke-node"]
        
    }
}