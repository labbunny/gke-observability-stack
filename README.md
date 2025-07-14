# Project Overview

This repository contains infrastructure and application deployment code for a cloud-native environment, organized as follows:

## Structure

- **terraform/**: Infrastructure as Code for provisioning cloud resources (e.g., networks, GKE clusters) using Terraform.
- **k8s/**: Kubernetes manifests and Helm deployment scripts for deploying applications and observability tools.

## Getting Started

For detailed setup, deployment, and maintenance instructions:

- See [`terraform/README.md`](./terraform/README.md) for provisioning cloud infrastructure.
- See [`k8s/README.md`](./k8s/README.md) for deploying applications and observability tools to Kubernetes.

Each subfolder contains example configuration files and step-by-step guides to help you recreate and manage your own environment.

## Prerequisites: Tool Installation

Before following the instructions in the subfolders, ensure you have the following tools installed:

### 1. Terraform
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Example (Linux):
  ```sh
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
  terraform -version
  ```

### 2. Google Cloud SDK (gcloud)
- [Install gcloud](https://cloud.google.com/sdk/docs/install)
- Example (Linux):
  ```sh
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-441.0.0-linux-x86_64.tar.gz
  tar -xf google-cloud-sdk-441.0.0-linux-x86_64.tar.gz
  ./google-cloud-sdk/install.sh
  source ./google-cloud-sdk/path.bash.inc
  gcloud version
  ```

### 3. kubectl (Kubernetes CLI)
- [Install kubectl](https://kubernetes.io/docs/tasks/tools/)
- Example (Linux):
  ```sh
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
  kubectl version --client
  ```

### 4. Helm (Kubernetes package manager)
- [Install Helm](https://helm.sh/docs/intro/install/)
- Example (Linux):
  ```sh
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  helm version
  ```

---

_If you have questions or need further customization, review the README in each subfolder or reach out to the project maintainer._ 