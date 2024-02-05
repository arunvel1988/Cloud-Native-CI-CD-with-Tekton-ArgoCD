#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: Automates the installation of Kubernetes in Docker (Kind)


# Specify the desired Kind version
KIND_VERSION="v0.11.1"

# Download Kind binary
wget "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64" -O kind

# Make it executable
chmod +x kind

# Move to a directory in your PATH
sudo mv kind /usr/local/bin/

# Verify installation
kind version
