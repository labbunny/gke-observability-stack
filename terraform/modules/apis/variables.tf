variable "project_id" {
    type = string
    description = "The ID of the project to enable the APIs for"
}

variable "required_apis" {
    type = list(string)
    description = "The list of APIs to enable"

    default = [
        "container.googleapis.com",
        "compute.googleapis.com",
        "iam.googleapis.com",
        "cloudresourcemanager.googleapis.com"
    ]
}