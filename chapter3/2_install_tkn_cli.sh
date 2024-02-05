#!/bin/bash
#Book Name: Cloud Native CI/CD with Tekton & ArgoCD
#Authors: Arunvel Arunachalam/ Ajay Arunachalam
#Purpose: # Script to install the tkn tool on a Kubernetes cluster
#Tested on Ubuntu 22.04


#for version check https://github.com/tektoncd/cli


# Specify the desired tkn version
TKN_VERSION="v0.19.0"

# Download tkn binary
wget "https://github.com/tektoncd/cli/releases/download/${TKN_VERSION}/tkn_$(uname | tr '[:upper:]' '[:lower:]')_amd64" -O tkn

# Make it executable
chmod +x tkn

# Move to a directory in your PATH
sudo mv tkn /usr/local/bin/

# Verify installation
tkn version
