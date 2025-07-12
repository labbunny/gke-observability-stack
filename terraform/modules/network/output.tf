output "network_name" {
    value = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
    value = google_compute_subnetwork.vpc_subnetwork.name
}

output "network_self_link" {
    value = google_compute_network.vpc_network.self_link
}

output "subnetwork_self_link" {
    value = google_compute_subnetwork.vpc_subnetwork.self_link
}
