variable "dns_zone_name" {
    type = string
    description = "The name of the DNS zone"
    default = "test-gke-si"
}

variable "dns_name" {
    type = string
    description = "The name of the DNS zone"
    default = "test.gke.si"
}