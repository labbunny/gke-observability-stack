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

---

_If you have questions or need further customization, review the README in each subfolder or reach out to the project maintainer._ 