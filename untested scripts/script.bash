# Step 1: Start Minikube
minikube start

# Step 2: Build Docker Image
docker context use default
docker build -t your-ejabberd-image .

# Step 3: Get Minikube IP
$minikube_ip = minikube ip

# Step 4: Load Docker Image into Minikube
minikube docker-env | Invoke-Expression
docker tag your-ejabberd-image $minikube_ip/your-ejabberd-image

# Step 5: Apply Kubernetes Manifests
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/persistentvolumeclaim.yaml

# Step 5.1: Ejabberd running
Write-Host "ejabberd is running at: http://$minikube_ip"

# Step 6: Cleanup (optional)
# Uncomment the following lines if you want to automatically cleanup resources after testing
trap { kubectl delete -f kubernetes/deployment.yaml -f kubernetes/service.yaml -f kubernetes/persistentvolumeclaim.yaml; minikube stop } EXIT

# Step 7: Open ejabberd in default browser (optional)
# Uncomment the following line if you want to automatically open ejabberd in your default browser
Start-Process "http://$minikube_ip"