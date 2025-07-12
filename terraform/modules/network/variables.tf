variable "network_name" {
    type = string
    description = "The name of the network"
}

variable "subnetwork_name" {
    type = string
    description = "The name of the subnetwork"
}

variable "region" {
    type = string
    description = "The region of the subnetwork"
}

variable "subnetwork_ip_cidr_range" {
    type = string
    description = "The IP CIDR range of the subnetwork"
    default = "10.0.0.0/24"
}