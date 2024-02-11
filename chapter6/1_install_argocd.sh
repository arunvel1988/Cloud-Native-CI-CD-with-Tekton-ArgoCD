#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: To install argocd
#Tested on Ubuntu 22.04

# Function to check if kubectl is available
check_kubectl() {
    if command -v kubectl &> /dev/null; then
        echo "kubectl is installed."
    else
        echo "kubectl is not installed. Please install kubectl before running this script."
        exit 1
    fi
}

# Function to check if a Kubernetes cluster is available
check_kubernetes_cluster() {
    if kubectl cluster-info &> /dev/null; then
        echo "Kubernetes cluster is available."
    else
        echo "Kubernetes cluster is not available. Please start a Kubernetes cluster before running this script."
        exit 1
    fi
}

# Function to install Argo CD
install_argo_cd() {
    echo "Installing Argo CD..."

    # Create the argocd namespace
    kubectl create namespace argocd

    # Apply Argo CD manifests
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    # Wait for Argo CD server to be ready
    kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s

    # Retrieve the initial admin password
    ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

    # Display the initial admin password
    echo "Argo CD Initial Admin Password: $ARGOCD_PASSWORD"

    # Port forward to access Argo CD locally
    kubectl port-forward svc/argocd-server -n argocd 8081:443 &

    # Wait for port forwarding to be ready
    sleep 5

    # Log in to Argo CD using the initial admin password
    argocd login localhost:8081 --username=admin --password="$ARGOCD_PASSWORD" --insecure

    read -p "Enter the new password for the admin user: " NEW_PASSWORD

    # Update the password for the admin user
    argocd account update-password --current-password="$ARGOCD_PASSWORD" --new-password="$NEW_PASSWORD"

    echo "Argo CD installation completed."
}

# Main script
check_kubectl
check_kubernetes_cluster
install_argo_cd
