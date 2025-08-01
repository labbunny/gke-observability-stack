# Terraform Infrastructure Overview

## What is Deployed

This Terraform configuration provisions the following Google Cloud resources:

- **APIs Module**: Enables all required Google Cloud APIs for the project.
- **Network Module**: Creates a custom VPC network and subnetwork for secure, isolated communication.
- **Security Module**: Configures firewall rules to allow HTTP/HTTPS ingress traffic to GKE nodes only.
- **GKE Module**: Deploys a Google Kubernetes Engine (GKE) cluster with a dedicated node pool, using the custom network and firewall.

## How it Works

- The `environments/dev/main.tf` file orchestrates the deployment by invoking each module in sequence:
  1. **APIs** are enabled first to ensure all required services are available.
  2. **Network** is created next, depending on APIs.
  3. **Security** (firewall) is set up, depending on the network.
  4. **GKE** cluster is deployed, depending on security.
- Each module is parameterized via variables (e.g., project ID, region, network names), set in `terraform.tfvars` and `variables.tf`.
- The environment directory (e.g., `environments/dev/`) contains all configuration for a specific deployment environment.

## Why this Structure

- **Modularity**: Each major infrastructure component is isolated in its own module for reusability and clarity.
- **Dependency Management**: Explicit `depends_on` ensures resources are created in the correct order.
- **Security**: Only required ports (80, 443) are opened, and only to GKE nodes.
- **Best Practices**: Uses custom VPC, disables default node pool, and enables only required APIs for least privilege.

## Maintenance

- **To update resources**: Edit the relevant module or environment variable files, then run:
  ```sh
  cd terraform/environments/dev
  terraform plan
  terraform apply
  ```
- **To add new environments**: Copy the `dev` environment directory, adjust variables, and apply as above.
- **To add new modules**: Create a new module in `modules/`, then reference it in the environment's `main.tf`.
- **To destroy resources**: Run `terraform destroy` in the environment directory.
- **State Management**: State files are local by default; for team use, configure remote state (e.g., GCS backend).

## Prerequisites

- Terraform installed (v1.0+ recommended)
- Google Cloud account and project
- Service account credentials with appropriate permissions

## Getting Started

1. Copy the example variables file and edit it with your own values:
   ```sh
   cp environments/dev/terraform.tfvars.example environments/dev/terraform.tfvars
   # Edit environments/dev/terraform.tfvars to set your project_id, region, and zone
   ```

2. Authenticate with Google Cloud:
   ```sh
   gcloud auth application-default login
   ```
3. Initialize Terraform:
   ```sh
   cd terraform/environments/dev
   terraform init
   ```
4. Review and apply the plan:
   ```sh
   terraform plan
   terraform apply
   ```

## Accessing the GKE Cluster with kubectl

After deploying the infrastructure, you need to configure `kubectl` to access your GKE cluster:

1. Install the GKE gcloud auth plugin (if not already installed):
   ```sh
   apt-get install google-cloud-cli-gke-gcloud-auth-plugin
   ```
2. Get cluster credentials (replace <CLUSTER_NAME> and <LOCATION> with your actual values):
   ```sh
   gcloud container clusters get-credentials <CLUSTER_NAME> --location <LOCATION>
   ```
3. Verify your kubectl context and resources:
   ```sh
   kubectl config get-contexts
   kubectl get all
   ```

## Customizing Module Variables

Each module (e.g., network, gke, security, apis) defines its own set of input variables in a `variables.tf` file within the module directory (e.g., `modules/gke/variables.tf`).

You can override any of these variables by specifying them in your environment's `terraform.tfvars` file (e.g., `environments/dev/terraform.tfvars`).

Refer to each module's `variables.tf` for the list of available variables and their default values.

## Enabling DNS and TLS for Testing

To test proper DNS and TLS provisioning with this setup:

1. **Uncomment the `dns` module** in your environment's `main.tf` file (e.g., `environments/dev/main.tf`).
2. **Set the required variables** for the DNS module. Variable definitions and descriptions can be found in `modules/dns/variables.tf`.
3. **Purchase the domain** you want to use for your services (e.g., `example.com`).
4. **Configure your domain's NS records** at your domain registrar to point to the name servers provided by the Google Cloud DNS managed zone created by Terraform. This is a manual, one-time step per domain.

Once these steps are complete, Terraform will manage all DNS records and static IPs for your services, and GKE ManagedCertificates will provision TLS certificates automatically.

---

_This README describes the infrastructure as defined in the `terraform` directory. For further customization, review each module's variables and outputs._ 