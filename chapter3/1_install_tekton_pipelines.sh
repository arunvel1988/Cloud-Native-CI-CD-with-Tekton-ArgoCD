#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: Install Tekton Pipelines on Kubernetes Cluster.
#Tested on Ubuntu 22.04


# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if kubectl is installed
if ! command_exists kubectl; then
  echo "Error: kubectl not found. Please install kubectl."
  exit 1
fi

# Check if Kubernetes cluster is accessible
if ! kubectl cluster-info &>/dev/null; then
  echo "Error: Unable to connect to the Kubernetes cluster. Make sure your kubeconfig is properly configured."
  exit 1
fi

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Wait for Tekton components to be ready
kubectl wait --for=condition=Ready pod --all --namespace tekton-pipelines

echo "Tekton Pipelines installed successfully!"