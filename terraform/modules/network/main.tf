resource "google_compute_network" "vpc_network" {
    name = var.network_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
    name = var.subnetwork_name
    region = var.region
    network = google_compute_network.vpc_network.name
    ip_cidr_range = var.subnetwork_ip_cidr_range
}