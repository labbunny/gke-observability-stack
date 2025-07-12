set -e

echo "Deploying Observability Stack..."

echo "Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add fluent https://fluent.github.io/helm-charts

helm repo update


echo "Creating observability namespace..."
# kubectl create namespace observability
kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -

echo "Installing Loki..."
helm upgrade --install loki grafana/loki \
  --namespace observability \
  --create-namespace \
  --values loki-values.yaml

# echo "Installing Fluent Bit..."
# helm upgrade --install fluent-bit fluent/fluent-bit \
#   --namespace observability \
#   --create-namespace \
#   --values fluent-bit-values.yaml
  # --set loki.serviceName=loki.observability.svc.cluster.local

echo "Installing Promtail..."
helm upgrade --install promtail grafana/promtail \
  --namespace observability \
  --create-namespace \
  --set loki.serviceName=loki \
  --set loki.serviceNamespace=observability

# echo "Installing kube-prometheus-stack..."
# helm upgrade --install kube-prom-stack prometheus-community/kube-prometheus-stack \
#   --namespace observability \
#   --create-namespace \
#   --values kube-prom-stack-values.yaml \
#   --wait

# echo "Installing Jaeger..."
# helm upgrade --install jaeger jaegertracing/jaeger \
#   --namespace observability \
#   --create-namespace \


echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n observability --timeout=300s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n observability --timeout=300s


echo "Getting Grafana external IP..."
GRAFANA_IP=$(kubectl get svc -n observability kube-prom-stack-grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
PASSWORD=$(kubectl --namespace observability get secrets kube-prom-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d 2>/dev/null)
echo "Grafana is available at: http://$GRAFANA_IP"
echo "Default credentials: admin / $PASSWORD"






