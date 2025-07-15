module "apis" {
    source = "../../modules/apis"

    project_id = var.dev_config.project_id
}

module "network" {
    source = "../../modules/network"

    network_name = "dev-network"
    subnetwork_name = "dev-subnetwork"
    region = var.dev_config.region

    depends_on = [module.apis]
}

module "security" {
    source = "../../modules/security"
    network_self_link = module.network.network_self_link

    depends_on = [module.network]
}

module "gke" {
    source = "../../modules/gke"

    region = var.dev_config.region
    zone = var.dev_config.zone
    cluster_name = "dev-gke-cluster"
    network_self_link = module.network.network_self_link
    subnetwork_self_link = module.network.subnetwork_self_link

    depends_on = [module.security]
}

# Uncomment for DNS setup
# module "dns" {
#     source = "../../modules/dns"

#     depends_on = [module.apis]
# }