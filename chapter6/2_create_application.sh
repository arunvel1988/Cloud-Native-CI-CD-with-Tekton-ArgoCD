#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: Script to create argocd application via command line
#Tested on Ubuntu 22.04



# Function to check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if argocd is installed
if ! command_exists argocd; then
  echo "Error: argocd not found. Please install Argo CD CLI."
  exit 1
fi

# Variables
ARGOCD_SERVER="https://argocd-server.example.com"  # Replace with your Argo CD server URL
REPO_URL="https://github.com/your/repo.git"        # Replace with your Git repository URL
REPO_PATH="path/to/app"                            # Replace with the path to your application manifests
DEST_NAMESPACE="default"

# Login to Argo CD server (you may need to provide credentials)
argocd login --server="${ARGOCD_SERVER}" --username=admin --password=admin-password --insecure

# Create application and sync it
argocd app create my-app --repo="${REPO_URL}" --path="${REPO_PATH}" --dest-server="${KUBE_API_SERVER}" --dest-namespace="${DEST_NAMESPACE}" --sync-policy automated

# Check the sync status
echo "Waiting for application to sync..."
argocd app wait my-app --timeout=300
