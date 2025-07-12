resource "google_compute_firewall" "allow_gke_ingress" {
    name = "allow-gke-ingress"
    network = var.network_self_link
    
    direction = "INGRESS"

    allow {
        protocol = "tcp"
        ports = ["80", "443"]
    }

    source_ranges = ["0.0.0.0/0"]

    target_tags = ["gke-node"]

    priority = 1000
}