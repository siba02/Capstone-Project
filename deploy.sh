#!/bin/bash

set -e

echo " Starting TelcoCloud deployment..."

APP_DIR="$HOME/app"
K8S_DIR="$HOME/K8s"
IMAGE_NAME="telcocloud-network-app"

echo " Building Docker image..."
cd "$APP_DIR"
docker build -t "$IMAGE_NAME" .

echo " Deploying to Kubernetes..."
kubectl apply -f "$K8S_DIR"

echo " Waiting for pods to be ready..."
kubectl rollout status deployment/telcocloud-network-app

echo " Service details:"
kubectl get svc telcocloud-network-service

echo " Deployment completed successfully!"
echo " Access your application at:"
echo "   http://<EC2_PUBLIC_IP>:30909"
