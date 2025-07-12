provider "google" {
    project = var.dev_config.project_id
    region = var.dev_config.region
    zone = var.dev_config.zone
}