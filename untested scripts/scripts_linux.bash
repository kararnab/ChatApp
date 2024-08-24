#!/bin/bash

# Step 1: Start Minikube
minikube start

# Step 2: Build Docker Image
docker build -t your-ejabberd-image .

# Step 3: Load Docker Image into Minikube
eval $(minikube docker-env)
docker tag your-ejabberd-image $(minikube ip):your-ejabberd-image

# Step 4: Apply Kubernetes Manifests
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/persistentvolumeclaim.yaml

# Step 5: Get Minikube IP
minikube_ip=$(minikube ip)

echo "ejabberd is running at: http://$minikube_ip"

# Step 6: Cleanup (optional)
# Uncomment the following lines if you want to automatically cleanup resources after testing
trap "kubectl delete -f kubernetes/deployment.yaml -f kubernetes/service.yaml -f kubernetes/persistentvolumeclaim.yaml; minikube stop" EXIT

# Step 7: Open ejabberd in default browser (optional)
# Uncomment the following line if you want to automatically open ejabberd in your default browser
open "http://$minikube_ip"