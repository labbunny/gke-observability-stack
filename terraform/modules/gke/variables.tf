variable "region" {
    type = string
    description = "The region of the GKE cluster"
}

variable "zone" {
    type = string
    description = "The zone of the GKE cluster"
}

variable "cluster_name" {
    type = string
    description = "The name of the GKE cluster"
}

variable "gke_version_prefix" {
    type = string
    description = "The version prefix of the GKE cluster"
    default = "1.29"
}

variable "network_self_link" {
    type = string
    description = "The self link of the network"
}

variable "subnetwork_self_link" {
    type = string
    description = "The self link of the subnetwork"
}

variable "node_machine_type" {
    type = string
    description = "The machine type of the node pool"
    default = "e2-standard-2"
}

variable "node_count" {
    type = number
    description = "The number of nodes in the node pool"
    default = 2
}