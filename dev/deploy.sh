#!/bin/bash

echo "🚀 Deploying to Kubernetes..."

kubectl apply -f ~/platform/k8s/deployment.yaml
kubectl apply -f ~/platform/k8s/service.yaml

echo "✅ Deploy done!"
