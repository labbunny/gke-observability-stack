# echo "Deploying Prometheus and Grafana"
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update

# Observability Stack Deployment Script
# This script deploys Prometheus, Grafana, and other observability tools

set -e

echo "Deploying Observability Stack..."

# Add Helm repositories
echo "Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Create namespace for observability
echo "Creating observability namespace..."
kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -

# Install kube-prometheus-stack (Prometheus + Grafana + Alertmanager)
echo "Installing kube-prometheus-stack..."
helm upgrade --install kube-prom-stack prometheus-community/kube-prometheus-stack \
  --namespace observability \
  --create-namespace \
  --values kube-prom-stack-values.yaml \
  --wait

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n observability --timeout=300s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n observability --timeout=300s

# Wait for LoadBalancer to be provisioned
echo "Waiting for LoadBalancer to be provisioned..."
GRAFANA_IP=""
MAX_ATTEMPTS=30
ATTEMPT=0

while [ -z "$GRAFANA_IP" ] && [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
  echo "Attempt $((ATTEMPT + 1))/$MAX_ATTEMPTS: Waiting for external IP..."
  GRAFANA_IP=$(kubectl get svc -n observability kube-prom-stack-grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "")
  
  if [ -z "$GRAFANA_IP" ]; then
    sleep 10
    ATTEMPT=$((ATTEMPT + 1))
  fi
done

if [ -n "$GRAFANA_IP" ]; then
  echo "Grafana is available at: http://$GRAFANA_IP"
  
  # Get admin password
  echo "Getting admin password..."
  ADMIN_PASSWORD=$(kubectl --namespace observability get secrets kube-prom-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d 2>/dev/null || echo "admin123")
  echo "Default credentials: admin / $ADMIN_PASSWORD"
  
  echo ""
  echo "Service URLs:"
  echo "Grafana: http://$GRAFANA_IP"
  echo "Prometheus: http://$(kubectl get svc -n observability kube-prom-stack-kube-prome-prometheus -o jsonpath='{.spec.clusterIP}'):9090"
  
  echo ""
  echo "Observability stack deployment completed!"
  echo "You can now access Grafana at http://$GRAFANA_IP"
  echo "Check the README.md for more information about accessing the tools."
else
  echo "LoadBalancer external IP not available after $MAX_ATTEMPTS attempts"
  echo "You can still access Grafana using port-forward:"
  echo "kubectl port-forward -n observability svc/kube-prom-stack-grafana 3000:80"
  echo "Then visit: http://localhost:3000"
fi






