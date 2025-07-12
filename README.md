1. Install kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
2. Configure kubectl config for GKE - https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl
3. Install Helm - https://helm.sh/docs/helm/helm_install/
Helm chart Prometheus-Grafana - https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
4. ingress guide https://www.youtube.com/watch?v=GhZi4DxaxxE

# commands
gcloud auth login
apt-get install google-cloud-cli-gke-gcloud-auth-plugin
gcloud container clusters get-credentials dev-gke-cluster --location us-central1-a
k config get-contexts
k get all


kubectl apply -f k8s/microsim/deployment.yaml
kubectl apply -f k8s/microsim/service.yaml
kubectl get pods -l app=microsim