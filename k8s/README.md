# Kubernetes Manifests Overview

## What is Deployed

### Observability Stack (`k8s/observability`)
- **Helm-based deployment scripts** for:
  - Loki (log aggregation)
  - Promtail (log shipping)
  - kube-prometheus-stack (Prometheus for metrics, Grafana for dashboards, Alertmanager)
  - Jaeger (distributed tracing)
- **Custom values files** for each Helm chart (`loki-values.yaml`, `jaeger-values.yaml`, `kube-prom-stack-values.yaml`, etc.)
- **Shell script** to automate deployment (`deploy-observability.sh`)

### Microsim Application (`k8s/microsim`)
- **Kubernetes Deployment** for the `microsim` app (with environment variables for service graph, port, etc.)
- **Kubernetes Service** exposing the app via a LoadBalancer

## How it Works

- Observability tools are deployed using Helm and custom values files, via provided shell scripts.
- The `microsim` app is deployed using standard Kubernetes manifests (`deployment.yaml`, `service.yaml`).
- The observability stack is deployed to a dedicated namespace (`observability`).

## Why this Structure

- **Separation of Concerns**: Observability and application manifests are kept in separate directories.
- **Reproducibility**: Scripts and values files allow for easy recreation and customization.
- **Modularity**: Each tool/component can be deployed or modified independently.

## Maintenance

- **To update observability tools**: Edit the relevant values YAML file and re-run the deployment script.
- **To update the application**: Edit the deployment or service manifest and apply with `kubectl`.
- **To add new tools**: Add a new values file and update the deployment script.
- **To destroy resources**: Use `kubectl delete` or Helm uninstall commands as appropriate.

## Getting Started

### 1. Observability Stack

- Deploy using the provided script:
  ```sh
  cd observability
  ./deploy-observability.sh
  ```

### 2. Microsim Application

- Deploy the application:
  ```sh
  kubectl apply -f microsim/deployment.yaml
  kubectl apply -f microsim/service.yaml
  ```

## Configuring DNS and TLS for Observability Tools

To enable DNS and TLS for Grafana and Jaeger:

1. In the `observability` directory, update the `jaeger` and `grafana` certificate and ingress YAML files with your correct domain configurations (e.g., set your actual domain names).
2. In the corresponding values files (e.g., `jaeger-values.yaml`, `kube-prom-stack-values.yaml`), change the service type for Jaeger Query and Grafana from `LoadBalancer` to `ClusterIP`.
3. After making these changes, apply the four relevant YAML files using `kubectl`:
   ```sh
   kubectl apply -f <grafana-cert.yaml>
   kubectl apply -f <grafana-ingress.yaml>
   kubectl apply -f <jaeger-cert.yaml>
   kubectl apply -f <jaeger-ingress.yaml>
   ```

This will configure your observability tools to be accessible via your custom domains with TLS, using Ingress and ManagedCertificate resources.

---

_This README describes the Kubernetes manifests and deployment scripts in the `k8s` directory. For further customization, review each values file and manifest._ 