#!/bin/bash

#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: Installing argocd cli
#Tested on Ubuntu 22.04


ARGOCD_VERSION="v2.8.9"
OS="linux"
ARCH="amd64"
ARGOCD_CLI_URL="https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-${OS}-${ARCH}"

# Check if Argo CD CLI is already installed
if command -v argocd &> /dev/null; then
    echo "Argo CD CLI is already installed."
    exit 0
fi

# Download Argo CD CLI
curl -LO "${ARGOCD_CLI_URL}"

# Make the binary executable
chmod +x argocd-${OS}-${ARCH}

# Move the binary to a directory in your PATH (e.g., /usr/local/bin)
sudo mv argocd-${OS}-${ARCH} /usr/local/bin/argocd

# Verify installation
argocd version
