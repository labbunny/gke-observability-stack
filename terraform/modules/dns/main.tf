resource "google_compute_global_address" "grafana_static_ip" {
    name = "grafana-static-ip"
}

resource "google_compute_global_address" "jaeger_static_ip" {
    name = "jaeger-static-ip"
}


resource "google_dns_managed_zone" "dns_zone" {
    name = var.dns_zone_name
    dns_name = "${var.dns_name}."
}

resource "google_dns_record_set" "grafana_dns_record_set" {
    name = "grafana.${var.dns_name}."
    type = "A"
    ttl = 300
    managed_zone = google_dns_managed_zone.dns_zone.name
    rrdatas = [google_compute_global_address.grafana_static_ip.address]
}

resource "google_dns_record_set" "jaeger_dns_record_set" {
    name = "jaeger.${var.dns_name}."
    type = "A"
    ttl = 300
    managed_zone = google_dns_managed_zone.dns_zone.name
    rrdatas = [google_compute_global_address.jaeger_static_ip.address]
}
